## 安装elasticSearch

```
docker pull elasticsearch:7.4.0
```

```
docker run --name elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -d elasticsearch:7.4.0
```

```
#进入docker容器 安装ik分词器
elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.4.0/elasticsearch-analysis-ik-7.4.0.zip
```

```
http://localhost:9200/
```



## docker安装kibana

```
docker pull kibana:7.4.0
```

```
docker run --name kibana --link=elasticsearch:test  -p 5601:5601 -d kibana:7.4.0
```

```
http://localhost:5601
```



