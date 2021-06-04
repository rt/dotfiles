*GET*
```bash
curl -i -H "Accept: application/json" -H "Content-Type: application/json" http://mysite.com
curl -i -H "Accept: application/xml" -H "Content-Type: application/xml" http://mysite.com
```

*POST data*
```bash
curl --data "param1=value1&param2=value2" http://mysite.com
curl --form "fileupload=@filename.text" http://mysite.com
```

*HTTP Post*
```bash
curl -X POST -d @filename http://mysite.com
```

*Logging in*
```bash
curl -d "username=admin&password=admin&submit=Login" --dump-header headers http://mysite.com/login
curl -L -b headers http://mysite
```

*Auth*
```bash
curl --user name:password http://www.example.com
curl -H "Authorization: OAuth <ACCESS_TOKEN>" http://www.example.com
curl -H "Authorization: Bearer <ACCESS_TOKEN>" http://www.example.com
```

*Use proxy*
```bash
http_proxy=some-proxy.net:proxy-port curl -I https://somewhere.com
https_proxy=some-proxy.net:proxy-port curl -I https://somewhere.com:443
```

*Record log*
```bash
curl --trace-ascii test1.log https://somewhere.com
```


</dev/tcp/localhost/443 && echo Works
curl https://localhost/v2/ && echo Works


