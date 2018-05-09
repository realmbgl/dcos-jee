# dcos-jee

## running the samples

```
$ curl -L https://gist.githubusercontent.com/realmbgl/95a2b1d33389612b792149ca296fd6bc/raw/6920c4ce9ccd1ad657a701b5c921a26755cbbaa2/yml2json > yml2json
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
