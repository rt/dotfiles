# marks

My usage for the globals is to leave the top alpha row available for any
current story/project I'm working on.  The rest of the alphas are used as
global markers where right side is work and the left side is home.
 
*Home*
- A: qmk_firmwared: ryan.h 
-

I use <Leader>ev to bring up active .vimrc

*Work* (might not end up doing these because it's 3 chars)
- M: build.xml
- N: pom.xm
- E: build.gradle
- I: Jenkinsfile
- N: ~/dev/repos/dev/common/src/main/resources/ezrez.local.properties
- H: core-webapp/src/main/webapp/resources/shopping/package.json


## Reference
```
:marks      :show marks
ma          :set mark 'a
'a          :jump to line of mark
`a          :jump to position of mark
d`a         :delete (or any motion) to mark
``
''          
A-Z         :global
a-z         :buffer
]`          :next
[`          :prev
```
