# skeleton-devops

Devops tools, reference ...


### Services

Ingress Controller (https://www.orange-networks.com/blogs/210-ingress-controller-simplified-routing-in-kubernetes)

*Services*
- GitLab (gitlab.pebblefields.com)
- GitLab Runners (Helm Deployment)
- skeleton-client (www.pebblefields.com)
- skeleton-server-java (server.pebblefields.com)
- skeleton-data (ClusterIP)

### Maintenance Pods (or services?)

- Tasks
- Migration
- DB Backup (https://www.orange-networks.com/blogs/208-back-up-databases-using-kubernetes-cronjobs)

### package.json


| **Script**      | **Description**                                                                                                                                                            |
| ----------      | -------                                                                                                                                                                    |
| createdb        | Create dev databases (creates all by default, 'skeleton', 'skeleton_unit', 'skeleton_automation'). Or specify which databases to create (ex. `npm run createdb dev unit`).
| migrate         | Migrate to current db schema.  Passthru to https://github.com/theoephraim/node-pg-migrate . (Set environment with argument `env`. `env=dev` is the default)                |
| init-data       | Init data in a db, mainly used for automation tests (ie. `npm run init-data automation`)                                                                                   |
| ci-test         | Run ci tests against build/                                                                                                                                                |

