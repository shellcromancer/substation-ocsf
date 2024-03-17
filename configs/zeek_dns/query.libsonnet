local patterns = import '../../patterns.libsonnet';
local sub = import '../../substation.libsonnet';

local model = import '../../ocsf.libsonnet';

{
  transforms:
    [
      // query.type
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'qtype_name'), trg: model.query_type } }),
      // query.hostname
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'query'), trg: model.query_hostname } }),
      // query.class
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'qclass_name'), trg: model.query_class } }),
      // query.packet_uid
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'trans_id'), trg: model.query_packet_uid } }),
    ],
}
