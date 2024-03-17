local sub = import '../../substation.libsonnet';

{
  transforms: [
    sub.tf.obj.cp({ obj: { src: 'meta model', trg: '' } }),
    sub.tf.send.stdout(),
  ],
}
