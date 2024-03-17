local base = import 'base.libsonnet';
local connection_info = import 'connection_info.libsonnet';
local dst_endpoint = import 'dst_endpoint.libsonnet';
local metadata = import 'metadata.libsonnet';
local send = import 'send.libsonnet';
local src_endpoint = import 'src_endpoint.libsonnet';
local status = import 'status.libsonnet';
local traffic = import 'traffic.libsonnet';


{
  concurrency: 2,
  transforms:
    base.transforms
    + metadata.transforms
    + dst_endpoint.transforms
    + src_endpoint.transforms
    + connection_info.transforms
    + status.transforms
    + traffic.transforms
    + send.transforms,
}
