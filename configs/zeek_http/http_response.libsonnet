local patterns = import '../../patterns.libsonnet';
local sub = import '../../substation.libsonnet';

local model = import '../../ocsf.libsonnet';

{
  transforms:
    [
      // http_response.length
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'response_body_len'), trg: model.http_response_length } }),
      // http_response.status
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'status_msg'), trg: model.http_response_status } }),
      // http_response.code
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'status_code'), trg: model.http_response_code } }),
      // http_response.code
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'resp_mime_types.0'), trg: model.http_response_content_type } }),
    ],
}
