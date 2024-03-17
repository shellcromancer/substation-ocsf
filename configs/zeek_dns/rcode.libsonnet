local patterns = import '../../patterns.libsonnet';
local sub = import '../../substation.libsonnet';

local model = import '../../ocsf.libsonnet';

local id_to_val = {
  '0': 'NoError',
  '1': 'FormError',
  '2': 'ServError',
  '3': 'NXDomain',
  '4': 'NotImp',
  '5': 'Refused',
  '6': 'YXDomain',
  '7': 'YXRRSet',
  '8': 'NXRRSet',
  '9': 'NotAuth',
  '10': 'NotZone',
  '11': 'DSOTYPENI',
  '16': 'BADSIG_VERS',
  '17': 'BADKEY',
  '18': 'BADTIME',
  '19': 'BADMODE',
  '20': 'BADNAME',
  '21': 'BADALG',
  '22': 'BADTRUNC',
  '23': 'BADCOOKIE',
  '24': 'Unassigned',
  '25': 'Resevered',
  '99': 'Other',
};

{
  transforms:
    [
      // rcode_id
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'rcode'), trg: model.rcode_id } }),
      // rcode
      sub.tf.meta.switch(
        { cases: [
          {
            condition: sub.cnd.any([
              sub.cnd.str.eq({ obj: { src: model.rcode_id }, value: id }),
            ]),
            transform: sub.tf.obj.insert({ obj: { trg: model.rcode }, value: id_to_val[id] }),
          }
          for id in std.objectFields(id_to_val)
        ] }
      ),
    ],
}
