import fetch from 'node-fetch';

let url = process.argv[2];
let times = process.argv[3];

run1();

async function run() {
    if (!url || !times) {
        process.stderr.write('Must specify url and number of times to execute (ie "npm run load-test www.google.com 20');
        process.exit(1);;
    }

    times = parseInt(times);

    const promises = [];

    for (let i = 0; i < times; i++) {
        promises.push(new Promise((resolve, reject) => {
            console.log('calling ' + i);
            fetch(url, {
                method: 'get',
                headers: {
                    Accept: 'text/html',
                    'Content-Type': 'text/html',
                },
            }).then(res => {
                console.log(res.status + ': ' + i + ' ' + res);
                resolve();
            }).catch(e => {
                console.log('ERROR: ' + JSON.stringify(e));
                reject(e);
            });

        }));
    }

    console.time('getSkeleton');
    await Promise.all(promises);
    console.timeEnd('getSkeleton');
}

async function run1() {
    if (!url || !times) {
        process.stderr.write('Must specify url and number of times to execute (ie "npm run load-test www.google.com 20');
        process.exit(1);;
    }

    times = parseInt(times);

    const promises = [];

    let i = 0;
    const id = setInterval(() => {
        promises.push(new Promise((resolve, reject) => {
            console.log('calling ' + i);
            fetch(url, {
                method: 'get',
                headers: {
                    Accept: 'text/html',
                    'Content-Type': 'text/html',
                },
            }).then(res => {
                console.log(res.status + ': ' + res);
                resolve();
            }).catch(e => {
                console.log('ERROR: ' + JSON.stringify(e));
                reject(e);
            });

        }));
        i++;
        if (i === times - 1) {
            clearInterval(id);
        }
    }, 50);

    console.time('getSkeleton');
    await Promise.all(promises);
    console.timeEnd('getSkeleton');
}

async function run2() {
    if (!url || !times) {
        process.stderr.write('Must specify url and number of times to execute (ie "npm run load-test www.google.com 20');
        process.exit(1);;
    }

    times = parseInt(times);

    let count = 0;
    return new Promise((resolve, reject) => {
        console.time('getSkeleton');
        for (let i = 0; i < times + 20; i++) {
            console.log('calling ' + i);
            fetch(url, {
                method: 'get',
                headers: {
                    Accept: 'text/html',
                    'Content-Type': 'text/html',
                },
            }).then(res => {
                console.log(res.status + ': ' + i + ' ' + res);
                count++;
                if (count === times) {
                    console.timeEnd('getSkeleton');
                    resolve();
                }
            }).catch(e => {
                console.log('ERROR: ' + JSON.stringify(e));
                reject(e);
            });

        }
    });

}
