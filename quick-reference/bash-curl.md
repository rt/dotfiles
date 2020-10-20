*GET*
```
curl -i -H "Accept: application/json" -H "Content-Type: application/json" http://mysite.com
curl -i -H "Accept: application/xml" -H "Content-Type: application/xml" http://mysite.com
```

*POST data*
```
curl --data "param1=value1&param2=value2" http://mysite.com
curl --form "fileupload=@filename.text" http://mysite.com
```

*HTTP Post*
```
curl -X POST -d @filename http://mysite.com
```

*Logging in*
```
curl -d "username=admin&password=admin&submit=Login" --dump-header headers http://mysite.com/login
curl -L -b headers http://mysite
```
curl --user name:password http://www.example.com
curl -H "Authorization: OAuth <ACCESS_TOKEN>" http://www.example.com
curl -H "Authorization: Bearer <ACCESS_TOKEN>" http://www.example.com

