# OCSF - Zeek DNS

### Transform

```shell
$ substation_v1 -config config.json -file ../../testdata/zeek_dns.jsonl | jq .
{
  "activity_id": 6,
  "activity_name": "Traffic",
  "answers": [
    {
      "flag_ids": [
        3,
        4
      ],
      "flags": [
        "Recursion Desired",
        "Recursion Available"
      ],
      "packet_uid": 19671,
      "rdata": "31.3.245.133",
      "ttl": 3600
    }
  ],
  "category_name": "Network Activity",
  "category_uid": 4,
  "class_name": "DNS Activity",
  "class_uid": 4003,
  "dst_endpoint": {
    "ip": "192.168.4.1",
    "port": 53
  },
  "metadata": {
    "processed_time": "2024-03-09T20:36:21.032Z",
    "product": {
      "feature": {
        "name": "dns.log"
      },
      "name": "zeek",
      "vendor_name": "zeek"
    },
    "uid": "CMdzit1AMNsmfAIiQc",
    "version": "1.2-dev"
  },
  "query": {
    "class": "C_INTERNET",
    "hostname": "testmyids.com",
    "packet_uid": 19671,
    "type": "A"
  },
  "raw_data": {
    "AA": false,
    "RA": true,
    "RD": true,
    "TC": false,
    "TTLs": [
      3600
    ],
    "Z": 0,
    "answers": [
      "31.3.245.133"
    ],
    "id.orig_h": "192.168.4.76",
    "id.orig_p": 36844,
    "id.resp_h": "192.168.4.1",
    "id.resp_p": 53,
    "proto": "udp",
    "qclass": 1,
    "qclass_name": "C_INTERNET",
    "qtype": 1,
    "qtype_name": "A",
    "query": "testmyids.com",
    "rcode": 0,
    "rcode_name": "NOERROR",
    "rejected": false,
    "rtt": 0.06685185432434082,
    "trans_id": 19671,
    "ts": 1591367999.305988,
    "uid": "CMdzit1AMNsmfAIiQc"
  },
  "rcode": "NoError",
  "rcode_id": 0,
  "severity": "Informational",
  "severity_id": 1,
  "src_endpoint": {
    "ip": "192.168.4.76",
    "port": 36844
  },
  "status": "Success",
  "status_id": 1,
  "time": "2020-06-05T09:39:59.000Z",
  "type_name": "DNS Activity: Traffic",
  "type_uid": 400306
}
{
  "activity_id": 6,
  "activity_name": "Traffic",
  "category_name": "Network Activity",
  "category_uid": 4,
  "class_name": "DNS Activity",
  "class_uid": 4003,
  "dst_endpoint": {
    "domain": "one.one.one.one",
    "ip": "1.0.0.1",
    "location": {
      "continent": "Oceania",
      "coordinates": {
        "lat": -33.494,
        "long": 143.2104
      },
      "country": "AU"
    },
    "port": 53
  },
  "metadata": {
    "processed_time": "2024-03-09T20:36:21.032Z",
    "product": {
      "feature": {
        "name": "dns.log"
      },
      "name": "zeek",
      "vendor_name": "zeek"
    },
    "uid": "CMdzit1AMNsmfAIiQc",
    "version": "1.2-dev"
  },
  "query": {
    "class": "C_INTERNET",
    "hostname": "testmyids.com",
    "packet_uid": 8555,
    "type": "AAAA"
  },
  "raw_data": {
    "AA": false,
    "RA": false,
    "RD": true,
    "TC": false,
    "Z": 0,
    "id.orig_h": "99.61.71.8",
    "id.orig_p": 36844,
    "id.resp_h": "1.0.0.1",
    "id.resp_p": 53,
    "proto": "udp",
    "qclass": 1,
    "qclass_name": "C_INTERNET",
    "qtype": 28,
    "qtype_name": "AAAA",
    "query": "testmyids.com",
    "rcode": 0,
    "rcode_name": "NOERROR",
    "rejected": false,
    "trans_id": 8555,
    "ts": 1591367999.306059,
    "uid": "CMdzit1AMNsmfAIiQc"
  },
  "rcode": "NoError",
  "rcode_id": 0,
  "severity": "Informational",
  "severity_id": 1,
  "src_endpoint": {
    "domain": "99-61-71-8.lightspeed.austtx.sbcglobal.net",
    "ip": "99.61.71.8",
    "location": {
      "city": "Austin",
      "continent": "North America",
      "coordinates": {
        "lat": 30.3773,
        "long": -97.71
      },
      "country": "US",
      "postal_code": "78758",
      "region": "Texas"
    },
    "port": 36844
  },
  "status": "Success",
  "status_id": 1,
  "time": "2020-06-05T09:39:59.000Z",
  "type_name": "DNS Activity: Traffic",
  "type_uid": 400306
}
```
