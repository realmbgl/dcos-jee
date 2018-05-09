# dcos-jee

## setup

### install yml2json

Download the yml2json command.
```
$ curl -O https://s3.amazonaws.com/mbgl-universe/yml2json && chmod +x yml2json
```

Move it to a location that is on your PATH.
```
$ mv yml2json /usr/local/bin
```

### run the samples

Clone this repository.
```
git clone https://github.com/realmbgl/dcos-jee.git
```

Go to your favorite app server subfolder and run one of the samples using the following command.

```
$ yml2json <app-server>.yml | dcos marathon app add
```
**Note:** The TLS samples will only work on DC/OS enterprise. See [here]() for detailed instructions. 

Next launch marathon-lb.
```
dcos package install marathon-lb --yes
```

You now can access the app via the public agents. Go to your browser and enter.
```
http://<public-agent-ip>/petclinic
```


## app server samples

All samples install the petclinic.war web application.

### jetty

* [using fetch for jdk, jetty, and war](jetty/jetty-f.yml)
* [using jetty docker image, and fetch for war](jetty/jetty-if.yml)
* [with tls](jetty/jetty-if-tls.yml)


### open liberty

* [using liberty docker image, and fetch for war](liberty/liberty-if.yml)
* [with tls](liberty/liberty-if-tls.yml)
