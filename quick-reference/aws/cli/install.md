
```bash

docker pull amazon/aws-cli:latest

docker run --rm -it amazon/aws-cli --version

docker run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli command
```
