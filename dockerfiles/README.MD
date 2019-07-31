## Sha256 Digests

|            Image Name                  |  Tag   |                               Sha256 Digests                              |   Size |
| -------------------------------------- | ------ | ------------------------------------------------------------------------- |--------|
| `zakkg3/opennebula-alpine-bootstrap`   |  3.10  | `sha256:f8ce996723744679144255e634bc26276f51e5d3ab09ae57563441531ae19298` |  9.8MB |
| `zakkg3/opennebula`                    |  5.8.2 | `sha256:c4a8a8daca0321c18b026571220a478ddd8b01dbe78f38d560f11f51215de837` |  790MB |
| `zakkg3/opennebula-gate`               |  5.8.2 | `sha256:861f8a8c873cd6ea60991a10e1e2087a746d14eac2d55628b864a68498d41181` |  640MB |
| `zakkg3/opennebula-node`               |  5.8.2 | `sha256:e21ae6eb0a57d91e6254ed08a1decef201da8670b6bf6c9001af182ea08eadc5` |  392MB |
| `zakkg3/opennebula-flow`               |  5.8.2 | `sha256:0b53ec1e6c87a52d763de5b7387333b11134bf9238b73980f4538efc0521a48c` |  640MB |
| `zakkg3/opennebula-sunstone`           |  5.8.2 | `sha256:5417acbf5254ab782abe8c92c282cd69a1f09f0aaead7089e3806f59251ab588` |  792MB |


to update this table:

```console
$ docker images --format "table | {{.Repository}} | {{.Size}} | {{.Digest}} |"
```
