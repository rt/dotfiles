# Devops

Create a local env to check devops.
This would be the CI/CD env, pushing to the cloud (uat/prod)

*Infrastructure*
- VirtualBox
- Kubernetes
- Terraform

*Apps*
- GitLab
- Jenkins
- Selenium Grid

*Process*
- Dev
- Test
- Deploy

## A Good Pipeline

Have a cluster for each env (staging, qa, prod)
There is a repo for each for history, etc.  These will have kube configs, etc.
- qa-infrastructure
- prod-infrastructur

1. Dev
Dev may or may not have a local env.  Only interface with the infrastructure is the Dockerfile.  Pushes changes

```bash
git checkout -b new-branch
...
git push origin new-branch
```

This triggers (any branch in master) a build and release on `new-branch.staging.example.com`

2. Moving to QA
Asking for QA's time.

```bash
git checkout master
git merge new-branch 
git push #this would trigger anything

# Tagging will trigger the qa build
git tag 1.01
git push origin --tags
```

The tag triggers a checkout of qa-infrastructure patch/build the new tag 
Which in turn `new-branch.qa.example.com`

3. Moving to prod

If QA looks and passes, use a pull request to prod-infrastructure repo to take the change (no rebuild)
Which in turn `www.example.com`


