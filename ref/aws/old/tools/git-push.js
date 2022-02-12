/**
 * Not being used but some cloud providers allow deploy on git push (openshift, heroku, etc.)
 * Check in RSK for something newer if you ever need
 */
import path from 'path';
import fetch from 'node-fetch';
import { fs, cp } from './utils';
import run from './run';

// GitHub Pages
const remote = {
    name: 'github',
    url: 'https://github.com/username/yourproject.git',
    branch: 'master',
    website: 'https://rt.github.io/yourproject/',
    static: false,
};


const options = {
    cwd: path.resolve(__dirname, '../build'),
    stdio: ['ignore', 'inherit', 'inherit'],
};

/**
 * Deploy the contents of the `/build` folder to a remote server via Git.
 */
async function deploy() {
    // Initialize a new repository
    await fs.makeDir('build');
    await cp.spawn('git', ['init', '--quiet'], options);

    // Changing a remote's URL
    let isRemoteExists = false;
    try {
        await cp.spawn('git', ['config', '--get', `remote.${remote.name}.url`], options);
        isRemoteExists = true;
    } catch (error) {
        /* skip */
    }
    await cp.spawn('git', ['remote', isRemoteExists ? 'set-url' : 'add', remote.name, remote.url], options);

    // Fetch the remote repository if it exists
    let isRefExists = false;
    try {
        await cp.spawn('git', ['ls-remote', '--quiet', '--exit-code', remote.url, remote.branch], options);
        isRefExists = true;
    } catch (error) {
        await cp.spawn('git', ['update-ref', '-d', 'HEAD'], options);
    }
    if (isRefExists) {
        await cp.spawn('git', ['fetch', remote.name], options);
        await cp.spawn('git', ['reset', `${remote.name}/${remote.branch}`, '--hard'], options);
        await cp.spawn('git', ['clean', '--force'], options);
    }

    // Build the project in RELEASE mode which
    // generates optimized and minimized bundles
    process.argv.push('--release');
    if (remote.static) process.argv.push('--static');
    await run(require('./build').default);
    if (process.argv.includes('--static')) {
        await fs.cleanDir('build/*', {
            nosort: true,
            dot: true,
            ignore: ['build/.git', 'build/public'],
        });
        await fs.moveDir('build/public', 'build');
    }

    // Push the contents of the build folder to the remote server via Git
    await cp.spawn('git', ['add', '--all'], options);
    try {
        await cp.spawn('git', ['diff', '--cached', '--exit-code', '--quiet'], options);
    } catch (error) {
        await cp.spawn('git', ['commit', '--message', `Update ${new Date().toISOString()}`], options);
    }
    await cp.spawn('git', ['push', remote.name, `master:${remote.branch}`, '--set-upstream'], options);

    // Check if the site was successfully deployed
    const response = await fetch(remote.website);
    console.log(`${remote.website} => ${response.status} ${response.statusText}`);
}

export default deploy;
