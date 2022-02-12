## Google Clould / Appengine deploy

Download the Google Clout SDK > https://cloud.google.com/sdk/

One time only to setup account (google-cloud/sdk/)
This will log you into to a google account and retrieve your projects

```bash
./install.sh
source ~/.bash_profile
gcloud init
```

*Deploy*
```bash
npm run gcloud-prepare appengine appengine.yaml
cd deployments/appengine/
gcloud app deploy --project pebblewebsite
```


