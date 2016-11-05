# nginx-build-docker
build nginx rpm on Docker

## nginxのrpmのビルドをDockerでやってみた。

nginxのsrc rpmを取得してrpmbuildするだけのDockerfileを書いてみた。  
Docker知ってたら1時間ちょいぐらいあれば出来ると思うのでビルド手段としてはオススメかな。

今回はビルド環境にCentos7を選択し、nginxのバージョンはここにあるものから最新のものを選んできた。

- [Index of /packages/rhel/7/SRPMS/][srpm_hosting]

Write Dockerfile
=================

ビルドに必要なもの以外にもいくつかパッケージが入ってるがデバッグ用にvimとか入ってると後々役立ちます。  
それに、rpmビルド用コンテナなのでサイズもレイヤーもあまり気にしてません。

```
RUN yum update  -y
RUN yum install -y epel-release; \
    yum install -y autoconf automake libtool wget; \
    yum install -y git make vim less; \
    yum install -y gcc gcc-c++ pkgconfig pcre-devel tcl-devel expat-devel openssl-devel; \
    yum install -y perl-devel perl-ExtUtils-Embed GeoIP-devel libxslt-devel gd-devel; \
    yum install -y rpm-build ;\
    yum clean all
```

あとは後は作業用のディレクトリを作ってrpmをビルドするだけです。詳細は`Dockerfile`をみて下さい。  
今回は取ってきたSRPMをそのままビルドしているのでDockerfileも20行で收まっています。

How to build
============

Dockerfileが用意できたらあとは`docker build`でコンテナを作って生成されたrpmを取り出すだけです。  
最初のビルドはキャッシュにのってないのもあって10~15分ぐらいかかるのでコーヒーでも入れながら待ちましょう。

```
$ docker build -t ngx .
$ docker run -d --name ngx-tmp -t ngx
$ docker cp  ngx-tmp:/root/rpmbuild/RPMS/  target
```

`docker cp`で生成されたrpmファイルを取り出します。取り出したものは別途動作検証なりをしましょう。  
rpmの検証etcが終わったらあとはコンテナを停止・削除します。

```
$ docker stop ngx-tmp; docker rm ngx-tmp
```

たったこれだけでrpmが出来てしまいました。
ビルドオプションとか変えたい場合はいったんspecファイルを取り出してパッチを当てるなどをする必要があるかと思いますが、それはまた次の機会に。

Debug
=====

メモ代わり。

```
$ docker run -d -v `pwd`/target:/root/rpmbuild/RPMS --name ngx-build -t ngx
$ docker run -i --name ngx-tmp -t ngx /bin/bash
```

Docker Hub
==========
[yuokada/nginx-build-docker - Docker Hub][my_docker_hub]  
一応、Docker Hubにも登録してみた。

Link
====

- [SRPMを一撃でRPMビルドする。 (rpmコマンドでつい忘れがちな細かいオプションもおまけで記載) - Qiita][qiita_srpm]
- [Docker を使ってパッケージング · tatsushid.github.io][tatsushid_github]
- [darkautism/rpmbuild - Docker Hub][sample_hub]
- [Dockerfile リファレンス — Docker-docs-ja 1.12.RC ドキュメント][docker_reference]


[srpm_hosting]: http://nginx.org/packages/rhel/7/SRPMS/ "Index of /packages/rhel/7/SRPMS/"
[my_docker_hub]: https://hub.docker.com/r/yuokada/nginx-build-docker/ "yuokada/nginx-build-docker - Docker Hub"
[qiita_srpm]: http://qiita.com/koitatu3/items/49635de6ec40a5f30222 "SRPMを一撃でRPMビルドする。 (rpmコマンドでつい忘れがちな細かいオプションもおまけで記載) - Qiita"
[docker_reference]:  http://docs.docker.jp/engine/reference/builder.html#volume "Dockerfile リファレンス — Docker-docs-ja 1.12.RC ドキュメント"
[sample_hub]: https://hub.docker.com/r/darkautism/rpmbuild/ "darkautism/rpmbuild - Docker Hub"
[tatsushid_github]: http://tatsushid.github.io/blog/2015/12/packaging-with-docker/ "Docker を使ってパッケージング · tatsushid.github.io"
