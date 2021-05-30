# bash

To change bash versions change in the Dockerfile.

```bash
docker build -t bashtest .

# start at /
# docker run -it --rm -v "$HOME/projects/dotfiles/playground/bash":/root/app bash:5
docker run -it --rm -v "$HOME/projects/playground/envs/bash":/root/app bashtest
cd ~/app
bash run_tests
```

## Run Tests

Run app tests
```
./run_tests app
```

Run all tests
```
./run_tests
```

### Dependencies

- shUnit2

