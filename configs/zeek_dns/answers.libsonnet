local patterns = import '../../patterns.libsonnet';
local sub = import '../../substation.libsonnet';

local model = import '../../ocsf.libsonnet';

{
  transforms:
    [
      // answers.rdata
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'answers'), trg: 'meta answer.rdata' } }),
      // answers.ttl
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'TTLs'), trg: 'meta answer.ttl' } }),
      // answers.packet_uid
      sub.pattern.tf.conditional(
        condition=sub.cnd.any([
          sub.cnd.num.len.greater_than({ obj: { src: sub.helpers.obj.append(model.raw_data, 'answers') }, value: 0 }),
        ]),
        transform=sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'trans_id'), trg: 'meta answer.packet_uid.-1' } }),
      ),
      sub.tf.obj.cp({ obj: { src: 'meta answer|@group', trg: model.answers } }),
      // answers.flags and answers.flag_ids
      sub.pattern.tf.conditional(
        condition=sub.cnd.all([
          sub.cnd.num.len.greater_than({ obj: { src: sub.helpers.obj.append(model.raw_data, 'answers') }, value: 0 }),
          sub.cnd.str.eq({ obj: { src: sub.helpers.obj.append(model.raw_data, 'AA') }, value: 'true' }),
        ]),
        transform=sub.tf.meta.pipe({ transforms: [
          sub.tf.obj.insert({ obj: { trg: sub.helpers.obj.append_array('answers.0.flags') }, value: 'Authoritative Answer' }),
          sub.tf.obj.insert({ obj: { trg: sub.helpers.obj.append_array('answers.0.flag_ids') }, value: 1 }),
        ] })
      ),
      sub.pattern.tf.conditional(
        condition=sub.cnd.all([
          sub.cnd.num.len.greater_than({ obj: { src: sub.helpers.obj.append(model.raw_data, 'answers') }, value: 0 }),
          sub.cnd.str.eq({ obj: { src: sub.helpers.obj.append(model.raw_data, 'TC') }, value: 'true' }),
        ]),
        transform=sub.tf.meta.pipe({ transforms: [
          sub.tf.obj.insert({ obj: { trg: sub.helpers.obj.append_array('answers.0.flags') }, value: 'Truncated Response' }),
          sub.tf.obj.insert({ obj: { trg: sub.helpers.obj.append_array('answers.0.flag_ids') }, value: 2 }),
        ] })
      ),
      sub.pattern.tf.conditional(
        condition=sub.cnd.all([
          sub.cnd.num.len.greater_than({ obj: { src: sub.helpers.obj.append(model.raw_data, 'answers') }, value: 0 }),
          sub.cnd.str.eq({ obj: { src: sub.helpers.obj.append(model.raw_data, 'RD') }, value: 'true' }),
        ]),
        transform=sub.tf.meta.pipe({ transforms: [
          sub.tf.obj.insert({ obj: { trg: sub.helpers.obj.append_array('answers.0.flags') }, value: 'Recursion Desired' }),
          sub.tf.obj.insert({ obj: { trg: sub.helpers.obj.append_array('answers.0.flag_ids') }, value: 3 }),
        ] })
      ),
      sub.pattern.tf.conditional(
        condition=sub.cnd.all([
          sub.cnd.num.len.greater_than({ obj: { src: sub.helpers.obj.append(model.raw_data, 'answers') }, value: 0 }),
          sub.cnd.str.eq({ obj: { src: sub.helpers.obj.append(model.raw_data, 'RA') }, value: 'true' }),
        ]),
        transform=sub.tf.meta.pipe({ transforms: [
          sub.tf.obj.insert({ obj: { trg: sub.helpers.obj.append_array('answers.0.flags') }, value: 'Recursion Available' }),
          sub.tf.obj.insert({ obj: { trg: sub.helpers.obj.append_array('answers.0.flag_ids') }, value: 4 }),
        ] })
      ),
      sub.pattern.tf.conditional(
        condition=sub.cnd.all([
          sub.cnd.num.len.greater_than({ obj: { src: sub.helpers.obj.append(model.raw_data, 'answers') }, value: 0 }),
          sub.cnd.str.eq({ obj: { src: sub.helpers.obj.append(model.raw_data, 'Z') }, value: 'true' }),
        ]),
        transform=sub.tf.meta.pipe({ transforms: [
          sub.tf.obj.insert({ obj: { trg: sub.helpers.obj.append_array('answers.0.flags') }, value: 'Other' }),
          sub.tf.obj.insert({ obj: { trg: sub.helpers.obj.append_array('answers.0.flag_ids') }, value: 99 }),
        ] })
      ),
    ],
}
