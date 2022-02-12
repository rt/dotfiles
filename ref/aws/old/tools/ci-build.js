import cp from 'child_process';
import { git } from './utils';

/**
 */
async function ciBuild() {
    
    function execSpawn(execCommand) {
        return new Promise((resolve, reject) => {

            console.log(`Executing: "${execCommand}"`);
            const commandParts = execCommand.split(' ');
            const command = commandParts.shift();
            const proc = cp.spawn(command, commandParts);

            proc.once('exit', (code, signal) => {
                resolve(execCommand);
            });
            proc.stdout.on('data', x => process.stdout.write(x));
            proc.stderr.on('data', x => process.stderr.write(x));

        });
    }

    return new Promise(async (resolve, reject) => {

        let commit = await git.getTag();
        commit = commit.trim();

        //1. build images
        await execSpawn(`npm run build-images ${process.argv[3]} ${commit}`);

        //2. migrate 
        await execSpawn(`npm run build-uat launchMigrateService ${commit}`);

        //3. update app 
        await execSpawn(`npm run build-uat updateService ${commit}`);

        return resolve();

    });
}

export default ciBuild;
