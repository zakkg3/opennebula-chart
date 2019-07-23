# Opennebula control plane Chart.

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install stable/opennebula --name my-release
```
Or you can run it with [helmfile](https://github.com/roboll/helmfile) :

```console
$ helmfile sync
```


The command deploys envoy on the Kubernetes cluster with the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.



## Configuration

All user-configurable settings, default values and some commentary about them can be found in [values.yaml](values.yaml).

## Automatic secrets creation.

This chart will create 2 secrets if you enable this on the values file.
This secrets are not being tracked by helm, so if you want to reinstall the chart you will need to delete them, see the [garbage collector](#garbage collector) topic above.

## Create SSH KEYS.
https://kubernetes.io/docs/concepts/configuration/secret/#use-case-pod-with-ssh-keys

This can be done by:
* enabling auto_ssh in values.yaml
* running ./createSshkeys.ch
* running this:

```bash

kubectl create namespace opennebula

mkdir opennebula-ssh-keys
ssh-keygen -f opennebula-ssh-keys/id_rsa -C oneadmin -P ''
cat opennebula-ssh-keys/id_rsa.pub > opennebula-ssh-keys/authorized_keys

cat > opennebula-ssh-keys/config <<EOT
Host *
    LogLevel ERROR
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
    GSSAPIAuthentication no
    User oneadmin
EOT

kubectl create secret generic -n opennebula opennebula-ssh-keys --from-file=opennebula-ssh-keys
```

## Automate serveradmin user.

The `serveradmin` user is a special username only used for sunstone and other services. It's not for final users.
This username is created on bootstrap by onedeamon and its not possible at the moment to pre mount a secret.
Enable `auto_serveradmin_secret` in values file to make this chart automate the creation of the secret for serveradmin 
from the onedeamon's `/var/lib/one/.one/sunstone_auth`


To restart sunstone after creating the secret:
https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.10/#delete-58
https://docs.openshift.com/container-platform/3.7/rest_api/api/v1.Pod.html#curl-request-11

## Garbage collector

as this chart is creating some resources automatically, helm is not tracking them.
we are talking about:

* opennebula-ssh-keys (secret)
* opennebula-server  (secret)
* opennebula-api (role)

For delete evertihing related with opennebula helm deploy please delete it  manually, or if you installed it in opennebula namespace (default in helmfile) you can use the secript ./deleteall.sh


## Build Dockerfiles.

1 - Edit dockerfiles/makedocker.sh
  export the commit ref name and the user to tag the image.
2 - run ./makedockler.sh


## Known Issues.

* Minikikube have some problems exposing TCP with services. It may not work on minikube if you access the ui using proxy port.
 Sunstone prints bad password in the UI and 401 status is returned in the logfiles with debug_level = 3
 It may be related with https://github.com/kubernetes/minikube/issues/2840



### TO-DO 

- [ ] Memchaed

- [ ] HA onedeamon.
   http://docs.opennebula.org/5.8/advanced_components/ha/frontend_ha_setup.html#opennebula-ha-setup

- [ ] health check
   http://docs.opennebula.org/5.8/advanced_components/ha/frontend_ha_setup.html#checking-cluster-health
