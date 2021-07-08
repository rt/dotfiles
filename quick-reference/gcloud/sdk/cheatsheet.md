# Cheatsheet

### Getting started
```bash

gcloud init               # Initialize, authorize, and configure the gcloud tool.
gcloud version            # Display version and installed components.
gcloud components install # Install specific components.
gcloud components update  # Update your Cloud SDK to the latest version.
gcloud config set project # Set a default Google Cloud project to work on.
gcloud info               # Display current gcloud tool environment details.
gcloud help               # Search the gcloud tool reference documents for specific terms.
gcloud topic              # Supplementary help material for non-command topics like accessibility, filtering, and formatting.

```

### Personalization
```bash

gcloud config set                     # Define a property (like compute/zone) for the current configuration.
gcloud config get-value               # Fetch value of a Cloud SDK property.
gcloud config list                    # Display all the properties for the current configuration.
gcloud config configurations create   # Create a new named configuration.
gcloud config configurations list     # Display a list of all available configurations.
gcloud config configurations activate # Switch to an existing named configuration.

```

### Credentials
```bash
gcloud auth login                    # Authorize Google Cloud access for the gcloud tool with Google user credentials and set current account as active.
gcloud auth activate-service-account # Like gcloud auth login but with service account credentials.
gcloud auth list                     # List all credentialed accounts.
gcloud auth print-access-token       # Display the current account's access token.
gcloud auth revoke                   # Remove access credentials for an account.

```

### Projects
```bash

gcloud projects list
gcloud projects describe               # Display metadata for a project (including its ID).
gcloud projects add-iam-policy-binding # Add an IAM policy binding to a specified project.

```

### Identity & Access Management
```bash

gcloud iam list-grantable-roles                    # List IAM grantable roles for a resource.
gcloud iam roles create                            # Create a custom role for a project or org.
gcloud iam service-accounts create                 # Create a service account for a project.
gcloud iam service-accounts add-iam-policy-binding # Add an IAM policy binding to a service account.
gcloud iam service-accounts set-iam-policy-binding # Replace existing IAM policy binding.
gcloud iam service-accounts keys list              # List a service account's keys.

```

### Docker & Google Kubernetes Engine (GKE)
```bash

gcloud auth configure-docker              # Register the gcloud tool as a Docker credential helper.
gcloud container clusters create          # Create a cluster to run GKE containers.
gcloud container clusters list            # List clusters for running GKE containers.
gcloud container clusters get-credentials # Update kubeconfig to get kubectl to use a GKE cluster.
gcloud container images list-tags         # List tag and digest metadata for a container image.

```

### Virtual Machines & Compute Engine
```bash

gcloud compute zones list         # List Compute Engine zones.
gcloud compute instances describe # Display a VM instance's details.
gcloud compute instances list     # List all VM instances in a project.
gcloud compute disks snapshot     # Create snapshot of persistent disks.
gcloud compute snapshots describe # Display a snapshot's details.
gcloud compute snapshots delete   # Delete a snapshot.
gcloud compute ssh                # Connect to a VM instance by using SSH.

```

### Serverless & App Engine
```bash

gcloud app deploy        # Deploy your app's code and configuration to the App Engine server.
gcloud app versions list # List all versions of all services deployed to the App Engine server.
gcloud app browse        # Open the current app in a web browser.
gcloud app create        # Create an App Engine app within your current project.
gcloud app logs read     # Display the latest App Engine app logs.

```

### Services
```bash
CLOUDSDK_CORE_PROJECT=remira-devops-1
gcloud services list --available --project remira-devops-1
gcloud services enable compute.googleapis.com --project remira-devops-1

```

### Miscellaneous
```bash

gcloud kms decrypt          # Decrypt ciphertext (to a plaintext file) using a Cloud Key Management Service (Cloud KMS) key.
gcloud logging logs list    # List your project's logs.
gcloud sql backups describe # Display info about a Cloud SQL instance backup.
gcloud sql export sql       # Export data from a Cloud SQL instance to a SQL file.

```



```bash
CLOUDSDK_CORE_PROJECT=<PRODUCTION_ID> gcloud app deploy
CLOUDSDK_CORE_PROJECT=griddatadisplaytest gcloud app deploy
gcloud app browse --project=griddatadisplaytest
```



