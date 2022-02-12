# Release Process

**Continuous Deployment**

Release directly to production.  If doing Continuous Deployment the User
Acceptance must be a part of each branch merge process.  If the client/user can
be convinced of the benefits then the below mentioned shuffling need not
happen.

In the merge request, the gatekeeper can see the last feature branch build.

| **Branch**     | **Deploy** | **Env**                     | **Note**             |
| ----------     | -------    | -------                     | -------              |
| feature-branch | Manual     | review/feature-branch = UAT | Available on-demand  |
| master or tags | Auto       | prod                        | All merges have tags |

**Continuous Deleviery**

Sometimes continous deployment is not an option due to confirmation process,
etc.  In these cases we want to only promote to production when we are ready.
For example, you could push to UAT every time a branch is merged into to
`master`.  Once approved, cut a release, promoting to production. 

| **Branch**     | **Deploy** | **Env**               | **Note**            |
| ----------     | -------    | -------               | -------             |
| feature-branch | Manual     | review/feature-branch | Available on-demand |
| master         | Auto       | review/master = UAT   | Current Edge        |
| tags           | Manual     | prod                  | Group of merges     |

*Troubles with continuous delivery*

Maintaining two environments has various overhead problems.  It is possible
that an urgent bug fix needs to go in to prod although there are already
features in master that haven't been user accepted.  In this case, the bug
branch could be based of the current release (tagged) and a new UAT could be
created from prod to test (special review app).

**Micro-Services Considerations**

Micro-services means more managing of timing.  Most backing services
don't need review/feature-branch. If using *continuous delivery* then
the timing that you are accepting in review/master(UAT) needs to be replicated 
in prod. If using *continous deployment* you only need to think about what
is in prod, but without the ability to test.

**UAT + Prod**

Adapting microservices to a UAT + Prod situation we can make the microservice
available to both uat current and future where the service needs to support both
similar to no-downtime databases.

**Process**

- Push to service repo
- GitLab will build the image
- GitLab will deploy the image to UAT kubernetes cluster
- QA tests performed like a minor release
- Push to production

**Database Change Required by Service**


### Process Flow

Setup to CI/CD from master to production. Branches are reviewed and merge by
GitLab gatekeeper (do in UI).  Each app must consider backward compatibility
and story dependencies.

**General Update**
- Client App: when pushed will be published to a cdn, or roll deploy containerized web server.
- Server App: when pushed will roll deploy
- Store App: when pushed will migrate (task)

**1. Dev**

```bash
git checkout master
git checkout -b my-story
git push -u origin my-story

... work, test

git push
```

This will do nothing.

If you need the image built, tag it (note: this is tagging your branch, not master)
This would allow a review app to be build manulally (or we could do a review app).

```
git tag 1.0
git push --tags   # is this right?
#git push origin --tags
```

If you are ready to merge create a merge request to the gate keeper.

**2. Gatekeeper**

The gatekeeper reviews the merge request and, if good, tags.

Can we merge with a tag?

```
git merge new-branch 
git push 

# Tagging will trigger the deployment?
git tag 2.01
git push origin --tags
```

Either the single merge + tag commit will trigger, or just the tag commit... not sure which is better.
