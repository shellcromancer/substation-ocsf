local patterns = import '../../patterns.libsonnet';
local sub = import '../../substation.libsonnet';

local model = import '../../ocsf.libsonnet';

{
  transforms:
    [
      // traffic.bytes_in
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'orig_bytes'), trg: model.traffic_bytes_in } }),
      // traffic.bytes_out
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'resp_bytes'), trg: model.traffic_bytes_out } }),

      // traffic.bytes
      sub.tf.obj.cp({ obj: { src: model.traffic_bytes_in, trg: sub.helpers.obj.append_array(model.traffic_bytes) } }),
      sub.tf.obj.cp({ obj: { src: model.traffic_bytes_out, trg: sub.helpers.obj.append_array(model.traffic_bytes) } }),
      sub.tf.num.math.add({ obj: { src: model.traffic_bytes, trg: model.traffic_bytes } }),

      // traffic.packets_in
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'orig_pkts'), trg: model.traffic_packets_in } }),
      // traffic.packets_out
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'resp_pkts'), trg: model.traffic_packets_out } }),

      // traffic.packets
      sub.tf.obj.cp({ obj: { src: model.traffic_packets_in, trg: sub.helpers.obj.append_array(model.traffic_packets) } }),
      sub.tf.obj.cp({ obj: { src: model.traffic_packets_out, trg: sub.helpers.obj.append_array(model.traffic_packets) } }),
      sub.tf.num.math.add({ obj: { src: model.traffic_packets, trg: model.traffic_packets } }),
    ],
}
