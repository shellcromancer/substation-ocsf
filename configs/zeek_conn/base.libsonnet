local patterns = import '../../patterns.libsonnet';
local sub = import '../../substation.libsonnet';

local model = import '../../ocsf.libsonnet';

{
  transforms:
    patterns.tf.mv('@this', model.raw_data).transforms +
    [
      // time
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'ts'), trg: model.time } }),
      sub.tf.time.from.unix({ obj: { src: model.time, trg: model.time } }),
      sub.tf.time.to.str({ obj: { src: model.time, trg: model.time }, format: '2006-01-02T15:04:05.000Z' }),

      // category_*
      // category_uid
      sub.tf.obj.insert({ obj: { trg: model.category_uid }, value: 4 }),
      // category_name
      sub.tf.obj.insert({ obj: { trg: model.category_name }, value: 'Network Activity' }),

      // class_*
      // class_uid
      sub.tf.obj.insert({ obj: { trg: model.class_uid }, value: 4001 }),
      // class_name
      sub.tf.obj.insert({ obj: { trg: model.class_name }, value: 'Network Activity' }),

      // activity_*
      // activitiy_id
      sub.tf.obj.insert({ obj: { trg: model.activity_id }, value: 6 }),
      // activity_name
      sub.tf.obj.insert({ obj: { trg: model.activity_name }, value: 'Traffic' }),

      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'duration'), trg: model.duration } }),
    ]
    // severity_*
    + patterns.model.severity('Informational').transforms
    // type_*
    + patterns.model.type.transforms,
}
