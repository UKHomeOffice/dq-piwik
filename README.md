# DACC-DQ/Piwik
>
**Orchestrates deployment of PIWIK to ACP platforms**

[![build status](https://gitlab.digital.homeoffice.gov.uk/dacc-dq/piwik/badges/master/build.svg)](https://gitlab.digital.homeoffice.gov.uk/dacc-dq/piwik/commits/master)
[![coverage report](https://gitlab.digital.homeoffice.gov.uk/dacc-dq/piwik/badges/master/coverage.svg)](https://gitlab.digital.homeoffice.gov.uk/dacc-dq/piwik/commits/master)

# Requirements
*The following drone secrets must be set up for deployments to work*

| Drone Secrets | Example Values |
| -------- | -------- |
| KUBE_NAMESPACE | `dq-dev` |
| KUBE_SERVER | `https://kube-dev.dsp.notprod.****` |
| KUBE_TOKEN | `***` |
| PIWIK_DBNAME | `database name` |
| PIWIK_DBHOST | `host name(url)` |
| PIWIK_DBPASSWORD | `database password` |
| PIWIK_DBUSERNAME | `database username` |
| PIWIK_SALT | `salt for password hashing` |
| PIWIK_APP_HOST | `piwik-test.notprod.****` |

##### Command to add drone secret
`drone secret add --event <EVENT> --image [--conceal] <IMAGE> <REPO NAME> <KEY> <VALUE>`
```
example:
    drone secret add \
     --event pull_request \
     --event deployment \
     --image quay.io/ukhomeofficedigital/kd \
     --conceal \
     dacc-dq/piwik PIWIK_SALT xyz
```

# Deployments
> 
**Deployments are automatically ran once master branch is updated however you can also manually revert to a previous deployment from the command line**

##### Pipeline
1. Update master branch
2. Drone watches for changes and runs build based on the latest in master

##### Rollback
1. Execute the following code from command line

```
   drone deploy dacc-dq/piwik <BUILD NUMBER>
```

# Helpful Links
**ACP Drone CI Guide:** https://github.com/UKHomeOffice/application-container-platform/blob/master/how-to-docs/drone-how-to.md
