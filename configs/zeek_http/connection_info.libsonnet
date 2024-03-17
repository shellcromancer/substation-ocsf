local patterns = import '../../patterns.libsonnet';
local sub = import '../../substation.libsonnet';

local model = import '../../ocsf.libsonnet';

{
  transforms:
    [
      // connection_info.*
      // connection_info.protocol_name
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'proto'), trg: model.connection_info_protocol_name } }),
      // connection_info.protocol_num
      sub.tf.meta.switch(
        { cases: [
          {
            condition: sub.cnd.any([
              sub.cnd.str.eq({ obj: { src: model.connection_info_protocol_name }, value: 'udp' }),
            ]),
            transform: sub.tf.obj.insert({ obj: { trg: model.connection_info_protocol_num }, value: 17 }),
          },
          {
            condition: sub.cnd.any([
              sub.cnd.str.eq({ obj: { src: model.connection_info_protocol_name }, value: 'tcp' }),
            ]),
            transform: sub.tf.obj.insert({ obj: { trg: model.connection_info_protocol_num }, value: 1 }),
          },
        ] }
      ),
    ],
}
