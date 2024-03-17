local base = import 'base.libsonnet';
local dst_endpoint = import 'dst_endpoint.libsonnet';
local http_request = import 'http_request.libsonnet';
local http_response = import 'http_response.libsonnet';
local metadata = import 'metadata.libsonnet';
local send = import 'send.libsonnet';
local src_endpoint = import 'src_endpoint.libsonnet';
local status = import 'status.libsonnet';


{
  concurrency: 2,
  transforms:
    base.transforms
    + metadata.transforms
    + dst_endpoint.transforms
    + src_endpoint.transforms
    + http_request.transforms
    + http_response.transforms
    + status.transforms  // must be after http_response
    + send.transforms,
}
