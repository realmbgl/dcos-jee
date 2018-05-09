# dcos-jee

## running the samples

```
$ curl -O https://s3.amazonaws.com/mbgl-universe/yml2json
```

```
$ chmod +x yml2json
$ mv yml2json /usr/local/bin
```

```
$ yml2json <marathon>.yml | dcos marathon app add
```

## jetty

* [using fetch for jdk, jetty, and war](jetty/jetty-f.yml)
* [using jetty docker image, and fetch for war](jetty/jetty-if.yml)
* [with tls](jetty/jetty-if-tls.yml)


## open liberty

* [using liberty docker image, and fetch for war](liberty/liberty-if.yml)
* [with tls](liberty/liberty-if-tls.yml)
