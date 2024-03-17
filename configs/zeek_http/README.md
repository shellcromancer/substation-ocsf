# OCSF - Zeek HTTP
 
### Transform

Transform [Zeek HTTP logs](https://docs.zeek.org/en/master/scripts/base/protocols/http/main.zeek.html#id2) from a JSON representation to the OCSF.

```shell
$ substation -config config.json -input ../../testdata/zeek_http.jsonl | jq
```
