
Linux

```bash
echo -n "password123admin" | md5sum | awk '{print $1}'
```

MacOS

```bash
md5 -qs "password123admin"
```
