local patterns = import '../../patterns.libsonnet';
local sub = import '../../substation.libsonnet';

local model = import '../../ocsf.libsonnet';

{
  transforms:
    [
      // src_endpoint.ip
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'id\\.orig_h'), trg: model.src_endpoint_ip } }),
      // src_endpoint.port
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'id\\.orig_p'), trg: model.src_endpoint_port } }),
    ]
    // src_endpoint.domain
    + patterns.tf.dns.ip_lookup(src=model.src_endpoint_ip, trg=model.src_endpoint_domain)
    // src_endpoint.autonomous_system.*
    + patterns.tf.ip.as(key=model.src_endpoint_ip, prefix=model.src_endpoint_autonomous_system).transforms
    // src_endpoint.location.*
    + patterns.tf.ip.geo(key=model.src_endpoint_ip, prefix=model.src_endpoint_location).transforms,
}
