### What if?

#### An urgent bug fix is necessary and you must revert

If not urgent, a fix can be applied in the next release.  If it is a code
issue, reverting the release means changing the task definition back to the old
image.
```
- npm run revert-prod
```

Migrations run on both version of the code, but it might be better to revert as well.

```
- npm run migrate down
```

Analyze the database differences.  Master will still have the most recent code.
The fix can go in and release again.





