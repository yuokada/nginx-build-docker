# nginx-build-docker
build nginx rpm on Docker

## nginxのrpmのビルドをDockerでやってみた。

nginxのsrc rpmを取得してrpmbuildするだけのDockerfileを書いてみた。  
やってみたら1時間ちょいで出来たのでこれ割りとオススメ。

ビルド環境はCentos7を選択し、nginxのバージョンはここにあるものから最新のものを選んできた。

- [Index of /packages/rhel/7/SRPMS/](http://nginx.org/packages/rhel/7/SRPMS/ "Index of /packages/rhel/7/SRPMS/")

How to build
============

最初のビルドはキャッシュにのってないのもあって10分ぐらいかかります。

```
$ docker  build -t ngx .
# docker run -d -v `pwd`/target:/root/rpmbuild/RPMS --name ngx-tmp -t ngx
$ docker run -d --name ngx-tmp -t ngx
$ docker cp  ngx-tmp:/root/rpmbuild/RPMS/  target
```

Cleanup
=======
いろいろ作ったあとはコンテナを停止・削除します。

```
$ docker stop ngx-tmp; docker rm ngx-tmp
```

Debug
=====

メモ代わり。

```
$ docker run -d -v `pwd`/target:/root/rpmbuild/RPMS --name ngx-build -t ngx
$ docker run -i --name ngx-tmp -t ngx /bin/bash
```

Docker Hub
==========
[yuokada/nginx-build-docker - Docker Hub](https://hub.docker.com/r/yuokada/nginx-build-docker/ "yuokada/nginx-build-docker - Docker Hub")  
一応、Docker Hubにも登録してみた。

Link
====

- [SRPMを一撃でRPMビルドする。 (rpmコマンドでつい忘れがちな細かいオプションもおまけで記載) - Qiita](http://qiita.com/koitatu3/items/49635de6ec40a5f30222 "SRPMを一撃でRPMビルドする。 (rpmコマンドでつい忘れがちな細かいオプションもおまけで記載) - Qiita")
- [Docker を使ってパッケージング · tatsushid.github.io](http://tatsushid.github.io/blog/2015/12/packaging-with-docker/ "Docker を使ってパッケージング · tatsushid.github.io")
- [darkautism/rpmbuild - Docker Hub](https://hub.docker.com/r/darkautism/rpmbuild/ "darkautism/rpmbuild - Docker Hub")
- [Dockerfile リファレンス — Docker-docs-ja 1.12.RC ドキュメント](http://docs.docker.jp/engine/reference/builder.html#volume "Dockerfile リファレンス — Docker-docs-ja 1.12.RC ドキュメント")
