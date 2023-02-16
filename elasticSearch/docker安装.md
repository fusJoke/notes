## 安装elasticSearch

```
docker pull elasticsearch:7.17.1
```

```
docker run --name elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -d elasticsearch:7.17.1
```

```
#进入docker容器 安装ik分词器
elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.17.1/elasticsearch-analysis-ik-7.17.1.zip
```

```
http://localhost:9200
https://127.0.0.1:9200/_nodes #node集群信息
```

## docker安装kibana

```
docker pull kibana:7.17.1
```

```
docker run --name kibana --link=elasticsearch:test  -p 5601:5601 -d kibana:7.17.1
```

```
http://localhost:5601
```

```
docker exec -u 0 -it 容器id /bin/bash
```

```
docker run --name elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node"  --network dev-ingress --network-alias elasticsearch -d elasticsearch:7.17.1
```

```php
docker run --name kibana --network dev-ingress --network-alias kibana  -p 5601:5601 -d kibana:7.17.1
```

<<<<<<< HEAD
=======


>>>>>>> d6d9666
## 导入数据

```
cd /Users/wangfusheng/htdocs/do-test/tool/composertest/src/elastic
curl -H "Content-Type: application/json" -XPOST "localhost:9200/bank/_doc/_bulk?pretty&refresh" --data-binary "@store_search_log.json"
```

```
curl -H "Content-Type: application/json" -XPOST "http://192.168.65.101:9200/bank/_doc/_bulk?pretty&refresh" --data-binary "@store_search_log.json"
```

