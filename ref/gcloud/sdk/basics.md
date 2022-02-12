```
gcloud + release level (optional) + component + entity + operation + positional args + flags
```

- Release Level refers to the command’s release status.
-   Example: alpha for alpha commands, beta for beta commands, no release level needed for GA commands.
- Component refers to the different Google Cloud services.
-   Example: compute for Compute Engine, app for App Engine, etc.
- Entity refers to the plural form of an element or collection of elements under a component.
-   Example: disks, firewalls, images, instances, regions, zones for compute
- Operation refers to the imperative verb form of the operation to be performed on the entity.
-   Example: Common operations are describe, list, create/update, delete/clear, import, export, copy, remove, add, reset, restart, restore, run, and deploy.
- Positional args refer to the required, order-specific arguments needed to execute the command.
-   Example: <INSTANCE_NAMES> is the required positional argument for gcloud compute instances create.
- Flags refer to the additional arguments, --flag-name(=value), passed in to the command after positional args.
-   Example: --machine-type=<MACHINE_TYPE> and --preemptible are optional flags for gcloud compute instances create

**Global flags**

--help:      For when in doubt; display detailed help for a command.
--project:   If using a project other than the current one.
--quiet:     Disabling interactive prompting (and applying default values for inputs).
--verbosity: Can set verbosity levels at debug, info, warning, error, critical, and none.
--version:   Display gcloud version information.
--format:    Set output format as config, csv, default, diff, disable, flattened, get, json, list, multi, none, object, table, text, value, or yaml.

**Cleaning up results**
Extricate the most from your output with the filter, format, limit, and sort-by flags.

For Compute Engine instances with prefix us and not machine type f1-micro:
```bash
gcloud compute instances list --filter="zone ~ ^us AND -machineType:f1-micro"
```

For a list of projects created on or after 15 January 2018, sorted from oldest to newest, presented as a table with project number, project id and creation time columns with dates and times in local timezone:
```bash
gcloud projects list --format="table(projectNumber,projectId,createTime.date(tz=LOCAL))" --filter="createTime>=2018-01-15T12:00:00" --sort-by=createTime
```

For a list of ten Compute Engine instances with a label my-label (of any value):
```bash
gcloud compute instances list --filter="labels.my-label:*" --limit=10
```

