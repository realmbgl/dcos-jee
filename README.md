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



## running the tls samples

Running the TLS samples requires DC/OS enterprise. Also install the cli additions using the following command.
```
dcos package install dcos-enterprise-cli --yes
```

### create service account and service acccount secret

Before you can run the samples you need to create a service account and service account secret. This allows the container running your app server to interact with the DC/OS ca and execute certificate signing requests.

```
dcos security org service-accounts keypair priv.pem pub.pem

dcos security org service-accounts create -p pub.pem -d "testing" my-service-acct

dcos security secrets create-sa-secret priv.pem my-service-acct my-service-acct-secret

dcos security org users grant my-service-acct dcos:superuser full
```

