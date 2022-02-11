# typescript client debug example

Need to a chrome instance that vscode can connect to
```bash
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222 --no-first-run --no-default-browser-check --user-data-dir=$(mktemp -d -t 'chrome-remote_data_dir')
```

This still needs to transpile typescript
I think using `npm run dev` where it points to `ts-node` is the best way ... need to find an example of react/ts


