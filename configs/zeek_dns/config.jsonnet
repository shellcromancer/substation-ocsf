local answers = import 'answers.libsonnet';
local base = import 'base.libsonnet';
local dst_endpoint = import 'dst_endpoint.libsonnet';
local metadata = import 'metadata.libsonnet';
local query = import 'query.libsonnet';
local rcode = import 'rcode.libsonnet';
local send = import 'send.libsonnet';
local src_endpoint = import 'src_endpoint.libsonnet';
local status = import 'status.libsonnet';


{
  concurrency: 2,
  transforms:
    base.transforms
    + metadata.transforms
    + query.transforms
    + answers.transforms
    + rcode.transforms
    + dst_endpoint.transforms
    + src_endpoint.transforms
    + status.transforms  // must be after rcode
    + send.transforms,
}
