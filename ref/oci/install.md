# install

Make a user and get the ocid for that user in the UI.


```bash
mkdir ~/.oci
```

`~/.oci/config`

```
[DEFAULT]
key_file=~/.oci/oci_api_key.pem
user=<USER_OCID>
fingerprint=<USER_FINGERPRINT>
tenancy=<TENANCY_OCID>
region=us-phoenix-1
```

```bash
docker build ~/projects/dockerfiles/oci/Dockerfile
docker tag <image-id> pebble/oci-cli


docker run --rm --mount type=bind,source=$HOME/.oci,target=/root/.oci stephenpearson/oci-cli:latest "$@";


# go into container, this will give you a config file and private and public key files
setup config

# copy the contents of the public key to the UI as the API Key

# most commands require the compartment id, convenient to set env variable.

export COMPARTMENT_ID=ocid1.tenancy.oc1..aaaaaaaaot3ihdt


# list all policies in compartment
oci iam policy list --compartment-id $COMPARTMENT_ID --all

# create policy to provision k8s
oci iam policy create  --name oke-service --compartment-id $COMPARTMENT_ID  --statements '[ "allow service OKE to manage all-re sources in tenancy"]' --description 'policy for granting rights on OKE to manage cluster resources'

# create a new compartment
oci iam compartment create --compartment-id $COMPARTMENT_ID  --name oke-compartment --description "Compartment for OCI resources created for OKE Cluster"


```
