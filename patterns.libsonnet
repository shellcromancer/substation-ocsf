local model = import 'ocsf.libsonnet';
local sub = import 'substation.libsonnet';


{
  cond: {
    is_external_ip(key=model.source_ip): sub.cnd.none(
      [sub.pattern.cnd.negate(sub.cnd.net.ip.valid(settings={ object: { src: key } }))] +
      sub.pattern.cnd.net.ip.internal(key=key)
    ),
  },
  tf: {
    mv(src, trg): {
      transforms:
        if src == '@this'
        then [
          sub.tf.obj.cp({ obj: { trg: 'meta __mv' } }),
          sub.tf.obj.cp({ obj: { src: 'meta __null' } }),
          sub.tf.obj.cp({ obj: { src: 'meta __mv', trg: trg } }),
          sub.tf.obj.del({ obj: { src: 'meta __mv' } }),
          sub.tf.obj.del({ obj: { src: 'meta __null' } }),
        ] else [
          sub.tf.obj.cp({ obj: { src: src, trg: trg } }),
          sub.tf.obj.del({ obj: { src: src } }),
        ],
    },
    dns: {
      ip_lookup(src, trg): [
        sub.pattern.tf.conditional(
          condition=sub.cnd.all([
            sub.cnd.net.ip.valid({ obj: { src: src } }),
            sub.pattern.cnd.negate(sub.cnd.net.ip.private({ obj: { src: src } })),
            sub.pattern.cnd.negate(sub.cnd.net.ip.multicast({ obj: { src: src } })),
          ]),
          transform=sub.tf.meta.err({ transform: sub.tf.enrich.dns.ip_lookup({ obj: { src: src, trg: trg } }) })
        ),
        sub.tf.meta.pipe({
          transforms: [
            sub.tf.obj.cp({ obj: { src: sub.helpers.obj.get_element(trg, 0), trg: trg } }),
            sub.tf.str.capture({ obj: { src: trg, trg: trg }, pattern: '^(.*)\\..*$' }),
          ],
        }),
      ],
    },
    ip: {
      as(key, prefix): {
        local _trg = 'meta tmp.as',

        local mmind_to_ocsf = {
          autonomous_system_number: 'number',
          autonomous_system_organization: 'organization',
        },

        local kv = sub.kv_store.mmdb({
          file: '/tmp/GeoLite2-ASN.mmdb',
        }),

        transforms: [
          sub.pattern.tf.conditional(
            condition=sub.cnd.all([
              sub.cnd.net.ip.valid({ obj: { src: key } }),
              sub.pattern.cnd.negate(sub.cnd.net.ip.private({ obj: { src: key } })),
            ]),
            transform=sub.tf.enrich.kv_store.get({
              obj: { src: key, trg: _trg },
              kv_store: kv,
            })
          ),
        ] + [
          sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(_trg, k), trg: sub.helpers.obj.append(prefix, mmind_to_ocsf[k]) } })
          for k in std.objectFields(mmind_to_ocsf)
        ] + [
          sub.tf.obj.del({ obj: { src: _trg } }),
        ],
      },
      geo(key, prefix): {
        local _trg = 'meta tmp.geo',

        local mmind_to_ocsf = {
          'city.names.en': 'city',
          'continent.names.en': 'continent',
          'country.iso_code': 'country',
          'location.longitude': 'coordinates.long',
          'location.latitude': 'coordinates.lat',
          'postal.code': 'postal_code',
          'subdivisions.0.names.en': 'region',
        },

        local kv = sub.kv_store.mmdb({
          file: '/tmp/GeoLite2-City.mmdb',
        }),

        transforms: [
          sub.pattern.tf.conditional(
            condition=sub.cnd.all([
              sub.cnd.net.ip.valid({ obj: { src: key } }),
              sub.pattern.cnd.negate(sub.cnd.net.ip.private({ obj: { src: key } })),
            ]),
            transform=sub.tf.enrich.kv_store.get({
              obj: { src: key, trg: _trg },
              kv_store: kv,
            })
          ),
        ] + [
          sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(_trg, k), trg: sub.helpers.obj.append(prefix, mmind_to_ocsf[k]) } })
          for k in std.objectFields(mmind_to_ocsf)
        ] + [
          sub.tf.obj.del({ obj: { src: _trg } }),
        ],
      },
    },
  },
  model: {
    type: {
      transforms:
        [
          // type_id: class_uid * 100 + activity_id.
          sub.tf.obj.cp({ obj: { src: model.class_uid, trg: sub.helpers.obj.append_array('meta type_uid') } }),
          sub.tf.obj.insert({ obj: { trg: sub.helpers.obj.append_array('meta type_uid') }, value: 100 }),
          sub.tf.num.math.mul({ obj: { src: 'meta type_uid', trg: model.type_uid } }),
          sub.tf.obj.del({ obj: { src: 'meta type_uid' } }),
          sub.tf.obj.cp({ obj: { src: model.type_uid, trg: sub.helpers.obj.append_array('meta type_uid') } }),
          sub.tf.obj.cp({ obj: { src: model.activity_id, trg: sub.helpers.obj.append_array('meta type_uid') } }),
          sub.tf.num.math.add({ obj: { src: 'meta type_uid', trg: model.type_uid } }),
          sub.tf.obj.del({ obj: { src: 'meta type_uid' } }),

          // type_name: class_name + ": " + activity_name
          sub.tf.obj.cp({ obj: { src: model.class_name, trg: sub.helpers.obj.append_array('meta type_name') } }),
          sub.tf.obj.cp({ obj: { src: model.activity_name, trg: sub.helpers.obj.append_array('meta type_name') } }),
          sub.tf.arr.join({ obj: { src: 'meta type_name', trg: model.type_name }, separator: ': ' }),
          sub.tf.obj.del({ obj: { src: 'meta type_name' } }),
        ],
    },
    severity(sev): {
      assert std.member([
        'Unkown',
        'Informational',
        'Low',
        'Medium',
        'High',
        'Critical',
        'Fatal',
        'Other',
      ], sev) == true : 'unsupported severity level',

      local ids = {
        Unknown: 0,
        Informational: 1,
        Low: 2,
        Medium: 3,
        High: 4,
        Critical: 5,
        Fatal: 6,
        Other: 99,
      },

      transforms: [
        sub.tf.obj.insert({ obj: { trg: model.severity }, value: sev }),
        sub.tf.obj.insert({ obj: { trg: model.severity_id }, value: ids[sev] }),
      ],
    },
    status_from_id(): {
      transforms: [
        sub.tf.meta.switch(
          { cases: [
            {
              condition: sub.cnd.any([
                sub.cnd.str.eq({ obj: { src: model.status_id }, value: '0' }),
              ]),
              transform: sub.tf.obj.insert({ obj: { trg: model.status }, value: 'Unknown' }),
            },
            {
              condition: sub.cnd.any([
                sub.cnd.str.eq({ obj: { src: model.status_id }, value: '1' }),
              ]),
              transform: sub.tf.obj.insert({ obj: { trg: model.status }, value: 'Success' }),
            },
            {
              condition: sub.cnd.any([
                sub.cnd.str.eq({ obj: { src: model.status_id }, value: '2' }),
              ]),
              transform: sub.tf.obj.insert({ obj: { trg: model.status }, value: 'Failure' }),
            },
          ] }
        ),
      ],
    },
  },
}
