```javascript
const fs = require('fs');
const path = require('path');

function walkDir(dir, callback) {
    fs.readdirSync(dir).forEach( f => {
        let dirPath = path.join(dir, f);
        let isDirectory = fs.statSync(dirPath).isDirectory();
        isDirectory ?
            walkDir(dirPath, callback) : callback(dir, f);
    });
};

function walkDirs(dirs, fn) {
    dirs.forEach(dir => {
        walkDir(dir, fn);
    });
}

exports.walkDirs = walkDirs;
```
