import path from 'path';
import { readFile } from './fs';
import { exec } from './cp';

export const getBranchName = () => {
    return new Promise(async (resolve, reject) => {
        const filepath = path.join(process.cwd(), '.git/HEAD');
        const str = await readFile(filepath);

        var match = /ref: refs\/heads\/([^\n]+)/.exec(str);
        const branchName = match[1];

        resolve(branchName);
    });
};
export const getCommitHash = () => {
    return new Promise(async (resolve, reject) => {
        const { stdout } = await exec('tail -1 .git/logs/HEAD');
        const commitHash = stdout.split(' ')[1];
        console.log(commitHash);
        resolve(commitHash);
    });
};
export const getTag = () => {
    return new Promise(async (resolve, reject) => {
        const { stdout } = await exec('git describe --tags');
        resolve(stdout);
    });
};

export default { getBranchName, getCommitHash, getTag };
