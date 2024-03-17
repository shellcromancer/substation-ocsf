# OCSF - Zeek Connection
 
### Transform

Transform [Zeek connection logs](https://docs.zeek.org/en/master/scripts/base/protocols/conn/main.zeek.html#base-protocols-conn-main-zeek) from a JSON representation to the OCSF.

```shell
$ substation_v1 -config config.json -file ../../testdata/zeek_conn.jsonl | jq -c | tail -1 | jq
{
  "activity_id": 6,
  "activity_name": "Traffic",
  "category_name": "Network Activity",
  "category_uid": 4,
  "class_name": "Network Activity",
  "class_uid": 4001,
  "connection_info": {
    "protocol_name": "udp",
    "protocol_num": 17
  },
  "dst_endpoint": {
    "ip": "ff02::1:2",
    "port": 547
  },
  "duration": 63.928922,
  "metadata": {
    "processed_time": "2024-03-17T11:28:45.091Z",
    "product": {
      "feature": {
        "name": "conn.log"
      },
      "name": "zeek",
      "vendor_name": "zeek"
    },
    "uid": "CRYedz3i8oxk3NQa25",
    "version": "1.2-dev"
  },
  "raw_data": {
    "conn_state": "S0",
    "duration": 63.928922,
    "history": "D",
    "id.orig_h": "fe80::9041:13ad:9ae4:9c77",
    "id.orig_p": 546,
    "id.resp_h": "ff02::1:2",
    "id.resp_p": 547,
    "local_orig": false,
    "local_resp": false,
    "missed_bytes": 0,
    "orig_bytes": 792,
    "orig_ip_bytes": 1176,
    "orig_pkts": 8,
    "proto": "udp",
    "resp_bytes": 0,
    "resp_ip_bytes": 0,
    "resp_pkts": 0,
    "sensorname": "securityonion-eth1",
    "ts": "2019-01-22T17:16:10.051197Z",
    "tunnel_parents": [],
    "uid": "CRYedz3i8oxk3NQa25"
  },
  "severity": "Informational",
  "severity_id": 1,
  "src_endpoint": {
    "ip": "fe80::9041:13ad:9ae4:9c77",
    "port": 546
  },
  "status": "Success",
  "status_id": 1,
  "time": "1969-12-31T18:00:00.000Z",
  "traffic": {
    "bytes": 792,
    "bytes_in": 792,
    "bytes_out": 0,
    "packets": 8,
    "packets_in": 8,
    "packets_out": 0
  },
  "type_name": "Network Activity: Traffic",
  "type_uid": 400106
}

```
