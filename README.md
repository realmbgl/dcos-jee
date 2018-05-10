# dcos-jee

## setup

### install yml2json

Download the yml2json command.
```
curl -O https://s3.amazonaws.com/mbgl-universe/yml2json && chmod +x yml2json
```

Move it to a location that is on your PATH.
```
mv yml2json /usr/local/bin
```

### run the samples

Clone this repository.
```
git clone https://github.com/realmbgl/dcos-jee.git
```

Go to your favorite app server subfolder and run one of the samples using the following command.

```
yml2json <app-server>.yml | dcos marathon app add
```
**Note:** The TLS samples will only work on DC/OS enterprise. See [here]() for detailed instructions. 

Next launch marathon-lb.
```
dcos package install marathon-lb --yes
```

You now can access the app via the public agent. Go to your browser and enter.
```
http://<public-agent-ip>/petclinic/
```


## app server samples

All samples install the petclinic.war web application.

### jetty

* [using fetch for jdk, jetty, and war](jetty/jetty-f.yml)
* [using jetty docker image, and fetch for war](jetty/jetty-if.yml)
* [with tls](jetty/jetty-if-tls.yml)

### tomcat

* [using tomcat docker image, and fetch for war](tomcat/tomcat-if.yml)
* [with tls](tomcat/tomcat-if-tls.yml)

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

### test using curl

Run the shell.yml from the root of the repo.
```
yml2json shell.yml | dcos marathon app add
```

Exec into the container.
```
dcos task exec -ti <shell-task-id> bash
```

Use the following curl command to test the connection. You should see the output as shown
```
curl -I --cacert .ssl/ca-bundle.crt https://jetty-pet.marathon.l4lb.thisdcos.directory:443/petclinic/

HTTP/1.1 200 OK
Content-Language: en
Content-Type: text/html;charset=utf-8
Content-Length: 3650
Server: Jetty(9.4.9.v20180320)
```

### testing using brower

Before we can access the app via the browser we need to expose it via edge-lb.

Once you have edge-lb install create a file named lb.yml with the following content.
```
apiVersion: V2
name: petproxy
count: 1
autoCertificate: true
haproxy:
  frontends:
    - bindPort: 443
      protocol: HTTPS
      certificates:
        - $AUTOCERT
      linkBackend:
        defaultBackend: petapp
  backends:
    - name: petapp
      protocol: HTTPS
      services:
        - endpoint:
            type: ADDRESS
            address: jetty-pet.marathon.l4lb.thisdcos.directory
            port: 443
```

Next you install this configuration.
```
dcos edgelb create lb.yml
```

You now can access the app via the public agent. Go to your browser and enter.
```
https://<public-agent-ip>:443/petclinic/
```
