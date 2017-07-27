# pyhton-build-docker
build python rpm on Docker

## roles

- [CentOS6.3で、Python2.7.3のRPMを作ってみた - 都内在住エンジニアの思考整理録](http://d.hatena.ne.jp/ckreal/20130103/1357171663 "CentOS6.3で、Python2.7.3のRPMを作ってみた - 都内在住エンジニアの思考整理録")
- [nmilford/rpm-python27: An RPM spec file build and alt-install Python 2.7 on RHEL.](https://github.com/nmilford/rpm-python27 "nmilford/rpm-python27: An RPM spec file build and alt-install Python 2.7 on RHEL.")
- [https://svn.python.org/projects/python/trunk/Misc/RPM/python-2.7.spec](https://svn.python.org/projects/python/trunk/Misc/RPM/python-2.7.spec "https://svn.python.org/projects/python/trunk/Misc/RPM/python-2.7.spec")
- [Python Release Python 2.7.11 | Python.org](https://www.python.org/downloads/release/python-2711/ "Python Release Python 2.7.11 | Python.org")

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
