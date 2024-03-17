local patterns = import '../../patterns.libsonnet';
local sub = import '../../substation.libsonnet';

local model = import '../../ocsf.libsonnet';

local http_method_to_id = {
  CONNECT: 1,
  DELETE: 2,
  GET: 3,
  HEAD: 4,
  OPTIONS: 5,
  POST: 6,
  PUT: 7,
  TRACE: 8,
};

local activity_id_to_name = {
  '0': 'Unknown',
  '1': 'Connect',
  '2': 'Delete',
  '3': 'Get',
  '4': 'Head',
  '5': 'Options',
  '6': 'Post',
  '7': 'Put',
  '8': 'Trace',
  '99': 'Other',
};

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
      sub.tf.obj.insert({ obj: { trg: model.class_uid }, value: 4002 }),
      // class_name
      sub.tf.obj.insert({ obj: { trg: model.class_name }, value: 'HTTP Activity' }),

      // activity_*
      // activitiy_id
      sub.tf.meta.switch(
        { cases: [
          {
            condition: sub.cnd.any([
              sub.cnd.str.eq({ obj: { src: sub.helpers.obj.append(model.raw_data, 'method') }, value: m }),
            ]),
            transform: sub.tf.obj.insert({ obj: { trg: model.activity_id }, value: http_method_to_id[m] }),
          }
          for m in std.objectFields(http_method_to_id)
        ] }
      ),
      // activity_name
      sub.tf.meta.switch(
        { cases: [
          {
            condition: sub.cnd.any([
              sub.cnd.str.eq({ obj: { src: model.activity_id }, value: id }),
            ]),
            transform: sub.tf.obj.insert({ obj: { trg: model.activity_name }, value: activity_id_to_name[id] }),
          }
          for id in std.objectFields(activity_id_to_name)
        ] }
      ),
    ]
    // severity_*
    + patterns.model.severity('Informational').transforms
    // type_*
    + patterns.model.type.transforms,
}
