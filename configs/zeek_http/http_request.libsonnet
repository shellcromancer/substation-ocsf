local patterns = import '../../patterns.libsonnet';
local sub = import '../../substation.libsonnet';

local model = import '../../ocsf.libsonnet';

{
  transforms:
    [
      // http_request.http_method
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'method'), trg: model.http_request_http_method } }),
      // http_request.user_agent
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'user_agent'), trg: model.http_request_user_agent } }),
      // http_request.version
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'version'), trg: model.http_request_version } }),
      // http_request.referrer
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'referrer'), trg: model.http_request_referrer } }),
      // http_request.length
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'request_body_len'), trg: model.http_request_length } }),
      // http_request.url
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'uri'), trg: model.http_request_url_path } }),
    ],
}
