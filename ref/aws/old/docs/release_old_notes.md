# Old notes

Keeping this for usage with aws in the past...



Continuous Deployment:  Run through all steps below for each release.  If not accepted at step 4., then go back to step 1.
Continuous Delivery:  Loop through steps 1 - 3 until user is ready to Biz-Accept a group of features, then do 4. and 5.

1. Developers develop on their own branch (watering with master if needed).  When finished all tests should pass.
```sh
$ npm run ci-test                               # Test all unit tests
```

Ready for pull request.

2. If UAT/Prod is not always up, build it.  Or, this could be a custom demo required before pushing.
```sh
$ npm run build-uat create v0.7.0           # If uat is not up 

# custom demo 
$ npm run build-images your_branch_name     # Create migrate/skeleton images
$ npm run build-uat create your_branch_name # This reqires migrate and skeleton images of your branch
```

3. Gatekeeper, test branch and merge. 

If this is a release, tag.  Even if tests or acceptance fails later, we fix and tag again (release just skips a number)
We will use [Semantic Versioning](http://semver.org)

```sh 
$ npm run release                           # Updates CHANGELOG.md, bumps version, and commits tags based on commit history.  https://www.npmjs.com/package/standard-version 
$ git push --follow-tags origin master      # Pushes to master, CI Pipeline will kick in again, acting on the tagged build
```

Run tests and build (normally done in CI pipeline).  This also will migrate and deploy to UAT.  The migrate happens via launch a server that runs the migrate container.

```sh
$ npm run ci-test                           # Builds and Tests all 
$ npm run ci-build pebble/dockerpebble1     # Build images (migrate and skeleton), push to docker repo, migrates and deploys to uat
```

4. User-Acceptance (Continuous Deployment)

All merges to master should end up here.  If accumulating features or if not accepted, loops back to 1.

5. Migrate and Deploy to production (TBD).

*Prod*

```sh
$ npm run build-prod launchMigrateService tag# Build production app to build/ directory
$ npm run build-prod updateService tag       # Build production app to build/ directory
```

Use the same image that was used in UAT.



