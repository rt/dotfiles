import { git, cp } from './utils';

/**
 */
async function buildImages() {
    
    return new Promise(async (resolve, reject) => {
        const usernameAndPassword = process.argv[3];
        if (!usernameAndPassword || usernameAndPassword.indexOf('/') === -1) {
            console.log('Must specify image repository username/password');
            reject();
        }
        //let commit = await git.getTag();
        //commit = commit.trim();
        let commit = process.argv[4];
        if (!commit) {
            console.log('Must specify image tag');
            reject();
        }

        const username = usernameAndPassword.split('/')[0];
        const password = usernameAndPassword.split('/')[1];
        
        await cp.execSpawn(`docker login --username=${username} --password=${password}`);

        await cp.exceSpawn(`docker build -t pebble/migrate-dynamodb:${commit} --no-cache -f Dockerfile_Migration_Service store_dynamodb/`);
        await cp.exceSpawn(`docker push pebble/migrate-dynamodb:${commit}`);

        await cp.exceSpawn(`docker build -t pebble/migrate:${commit} --no-cache -f Dockerfile_Migration_Service store/`);
        await cp.exceSpawn(`docker push pebble/migrate:${commit}`);
        
        await cp.exceSpawn(`npm run build`);
        await cp.exceSpawn(`docker build -t pebble/skeleton:${commit} --no-cache .`);
        await cp.exceSpawn(`docker push pebble/skeleton:${commit}`);

        return resolve();

    });
}

export default buildImages;
