
```bash
tar -czvf file.tar.gz .
tar -xzvf file.tar.gz

# pick and choose what you want
tar -czvf file.tar.gz $(find /dir -type f -maxdepth -name config.xml) /another/dir
```
