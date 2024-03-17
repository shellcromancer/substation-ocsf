local patterns = import '../../patterns.libsonnet';
local sub = import '../../substation.libsonnet';

local model = import '../../ocsf.libsonnet';

{
  transforms:
    [
      // dst_endpoint.ip
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'id\\.resp_h'), trg: model.dst_endpoint_ip } }),
      // dst_endpoint.port
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'id\\.resp_p'), trg: model.dst_endpoint_port } }),
    ]
    // dst_endpoint.domain
    + patterns.tf.dns.ip_lookup(src=model.dst_endpoint_ip, trg=model.dst_endpoint_domain)
    // dst_endpoint.autonomous_system.*
    + patterns.tf.ip.as(key=model.dst_endpoint_ip, prefix=model.dst_endpoint_autonomous_system).transforms
    // dst_endpoint.location.*
    + patterns.tf.ip.geo(key=model.dst_endpoint_ip, prefix=model.dst_endpoint_location).transforms,
}
