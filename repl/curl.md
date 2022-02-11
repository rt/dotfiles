
```bash
CURL_END_POINT=http://localhost:3000/endpoint
```

```bash
# verbose
curl -v $CURL_END_POINT

# save to file
curl -o out.json $CURL_END_POINT
```


*GET*
```bash
curl -i -H "Accept: application/json" -H "Content-Type: application/json" $CURL_END_POINT
curl -i -H "Accept: application/xml" -H "Content-Type: application/xml" $CURL_END_POINT
```

*POST data*
```bash
curl --data "param1=value1&param2=value2" $CURL_END_POINT
curl --form "fileupload=@filename.text" $CURL_END_POINT
```

*HTTP Post*
```bash
curl -X POST -d @filename $CURL_END_POINT
```

*Logging in*
```bash
curl -d "username=admin&password=admin&submit=Login" --dump-header headers $CURL_END_POINT
curl -L -b headers $CURL_END_POINT
```

*Auth*
```bash
curl --user name:password $CURL_END_POINT
curl -H "Authorization: OAuth <ACCESS_TOKEN>" $CURL_END_POINT
curl -H "Authorization: Bearer <ACCESS_TOKEN>" $CURL_END_POINT
```

*Use proxy*
```bash
http_proxy=some-proxy.net:proxy-port curl -I https://somewhere.com
https_proxy=some-proxy.net:proxy-port curl -I https://somewhere.com:443
```

*Record log*
```bash
curl --trace-ascii test1.log $CURL_END_POINT
```


</dev/tcp/localhost/443 && echo Works
curl https://localhost/v2/ && echo Works


