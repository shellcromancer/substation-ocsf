local patterns = import '../../patterns.libsonnet';
local sub = import '../../substation.libsonnet';

local model = import '../../ocsf.libsonnet';

{
  transforms:
    [
      // status_id
      sub.tf.meta.switch(
        { cases: [
          {
            condition: sub.cnd.any([
              sub.cnd.str.eq({ obj: { src: model.rcode_id }, value: '0' }),
            ]),
            transform: sub.tf.obj.insert({ obj: { trg: model.status_id }, value: 1 }),
          },
          {
            transform: sub.tf.obj.insert({ obj: { trg: model.status_id }, value: 2 }),
          },
        ] }
      ),
    ]
    + patterns.model.status_from_id().transforms,
}
