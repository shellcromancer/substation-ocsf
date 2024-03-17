local patterns = import '../../patterns.libsonnet';
local sub = import '../../substation.libsonnet';

local model = import '../../ocsf.libsonnet';

{
  transforms:
    [
      // status_id
      sub.tf.meta.switch(
        { cases: [
          // status_id: 2 -- Failure
          {
            condition: sub.cnd.any([
              sub.cnd.str.starts_with({ obj: { src: model.http_response_status }, value: '4' }),
              sub.cnd.str.starts_with({ obj: { src: model.http_response_status }, value: '5' }),
            ]),
            transform: sub.tf.obj.insert({ obj: { trg: model.status_id }, value: 2 }),
          },
          // status_id: 1 -- Success
          {
            transform: sub.tf.obj.insert({ obj: { trg: model.status_id }, value: 1 }),
          },
        ] }
      ),
    ]
    + patterns.model.status_from_id().transforms,
}
