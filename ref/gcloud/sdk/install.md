# SDK Install and Setup

Install direct 
https://cloud.google.com/sdk/docs/install

### Docker

:latest, :VERSION: Large (Debian-based) image with additional components pre-installed
:slim, :VERSION-slim: Smaller (Debian-based) image with no components pre-installed
:alpine, :VERSION-alpine: Smallest (Alpine-based) image with no additional components installed

```bash
docker pull gcr.io/google.com/cloudsdktool/cloud-sdk:latest

# verify
docker run --rm gcr.io/google.com/cloudsdktool/cloud-sdk:latest gcloud version

# run the container without --rm, you want to keep it around, logged in
docker run -it -v ~/projects/dotfiles/playground/gcloud:/gcloud --name gcloud-sdk gcr.io/google.com/cloudsdktool/cloud-sdk:latest bash

```

**init**
```bash
# or, if you are just starting
gcloud init --console-only

# auth: credentials are preserved in the volume of the gcloud-config container.
# or use individually
gcloud auth login
gcloud auth activate-service-account
gcloud config [COMMAND]
gcloud config configurations [COMMAND]


gcloud config list
```

**create new project**
All resources will be created in the project.
```bash
gcloud projects create PROJECT
```

**terraform install**
See terraform install

**terraform**

```bash
gcloud auth application-default login
```

