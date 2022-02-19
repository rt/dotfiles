
```bash
END_POINT=http://localhost:3000/endpoint
```

```bash
# verbose
curl -v $END_POINT
curl -v $END_POINT | jq '.'

# save to file
curl -o out.json $END_POINT
```


*GET*
```bash
curl -i -H "Accept: application/json" -H "Content-Type: application/json" $END_POINT
curl -i -H "Accept: application/xml" -H "Content-Type: application/xml" $END_POINT
```

*POST data*
```bash
curl --data "param1=value1&param2=value2" $END_POINT
curl --form "fileupload=@filename.text" $END_POINT
```

*HTTP Post*
```bash
curl -X POST -d @filename $END_POINT
```

*Logging in*
```bash
curl -d "username=admin&password=admin&submit=Login" --dump-header headers $END_POINT
curl -L -b headers $END_POINT
```

*Auth*
```bash
curl --user name:password $END_POINT
curl -H "Authorization: OAuth <ACCESS_TOKEN>" $END_POINT
curl -H "Authorization: Bearer <ACCESS_TOKEN>" $END_POINT
```

*Use proxy*
```bash
http_proxy=some-proxy.net:proxy-port curl -I https://somewhere.com
https_proxy=some-proxy.net:proxy-port curl -I https://somewhere.com:443
```

*Record log*
```bash
curl --trace-ascii test1.log $END_POINT
```


</dev/tcp/localhost/443 && echo Works
curl https://localhost/v2/ && echo Works


