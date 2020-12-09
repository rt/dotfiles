
**npm link**

```bash
cd ~/some-dep/
npm link # set global link

cd ~/app/
npm link some-dep

# do work ...

cd ~/app/
npm uninstall --no-save some-dep && npm install

cd ~/some-dep/
npm uninstall  # Delete global symlink

```

