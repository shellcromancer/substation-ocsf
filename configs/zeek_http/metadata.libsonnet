local patterns = import '../../patterns.libsonnet';
local sub = import '../../substation.libsonnet';

local model = import '../../ocsf.libsonnet';

{
  transforms:
    [
      // metadata.version
      sub.tf.obj.insert({ obj: { trg: model.metadata_version }, value: '1.2-dev' }),
      // metadata.uid
      sub.tf.obj.cp({ obj: { src: sub.helpers.obj.append(model.raw_data, 'uid'), trg: model.metadata_uid } }),
      // metadata.product.*
      sub.tf.obj.insert({ obj: { trg: model.metadata_product_name }, value: 'zeek' }),
      sub.tf.obj.insert({ obj: { trg: model.metadata_product_feature_name }, value: 'http.log' }),
      sub.tf.obj.insert({ obj: { trg: model.metadata_product_vendor_name }, value: 'zeek' }),
      // metadata.processed_time
      sub.tf.time.now({ obj: { trg: model.metadata_processed_time } }),
      sub.tf.time.to.str({ obj: { src: model.metadata_processed_time, trg: model.metadata_processed_time }, format: '2006-01-02T15:04:05.000Z' }),
    ],
}
