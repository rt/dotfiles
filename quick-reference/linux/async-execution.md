
##### async execution

```bash
echo "Parent: staring..."

echo "parent: launching child script..."
async-child &
pid=$!
echo "Parent: child (PID= $pid) launched."

echo "Parent: continuing ..."
sleep 2

echo "Parent: pausing to wait for child to finish ..."
wait $pid

echo "Parent: child is finished. Continuing..."
```


`async-child.sh`

```bash

#!/bin/bash
# async-child
echo "Child: child is running ..."
sleep 5
echo "Child: child is done. Exiting."

```

