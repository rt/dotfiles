# scripting

```bash
gcloud compute instances list --filter="zone:us-central1-a"

gcloud projects list
gcloud projects list --format="json" --filter="labels.env=test AND labels.version=alpha"
```


If you were to list all the keys associated with all your projects' service
accounts, you'd need to iterate over all your projects and for each project,
get all the service accounts associated with it. For each service account, get
all the keys.

```bash

for project in  $(gcloud projects list --format="value(projectId)")
do
  echo "ProjectId:  $project"
  for robot in $(gcloud iam service-accounts list --project $project --format="value(email)")
   do
     echo "    -> Robot $robot"
     for key in $(gcloud iam service-accounts keys list --iam-account $robot --project $project --format="value(name.basename())")
        do
          echo "        $key"
     done
   done
done

```
