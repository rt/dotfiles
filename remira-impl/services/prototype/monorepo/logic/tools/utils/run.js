import { formatTime } from './format';

function run(fn, options) {
    const task = typeof fn.default === 'undefined' ? fn : fn.default;
    const start = new Date();
    console.info(
        `[${formatTime(start)}] Starting '${task.name}${
            options ? ` (${options})` : ''
        }'...`
    );
    return task(options).then((resolution) => {
        const end = new Date();
        const time = end.getTime() - start.getTime();
        console.info(
            `[${formatTime(end)}] Finished '${task.name}${
                options ? ` (${options})` : ''
            }' after ${time} ms`
        );
        return resolution;
    });
}

if (require.main === module && process.argv.length > 2) {
    // eslint-disable-next-line no-underscore-dangle
    delete require.cache[__filename];

    // eslint-disable-next-line global-require, import/no-dynamic-require
    const module = require(`./${process.argv[2]}.js`).default;

    run(module).catch((err) => {
        console.error(err.stack);
        process.exit(1);
    });
}

export default run;
