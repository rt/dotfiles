import cp from 'child_process';

export const exec = (command, options) =>
    new Promise((resolve, reject) => {
        cp.exec(command, options, (err, stdout, stderr) => {
            if (err) {
                reject(err);
                return;
            }

            resolve({ stdout, stderr });
        });
    });

export const spawn = (command, args, options) =>
    new Promise((resolve, reject) => {
        const proc = cp.spawn(command, args, options);
        proc.on('close', (code) => {
            if (code === 0) {
                resolve();
            } else {
                reject(
                    new Error(`${command} ${args.join(' ')} => ${code} (error)`)
                );
            }
        });
        proc.stdout.on('data', (x) => process.stdout.write(x));
        proc.stderr.on('data', (x) => process.stderr.write(x));
    });

//getting maxBuffer exceede on CI env for exec (using spawn here)
export const execSpawn = (execCommand) =>
    new Promise((resolve, reject) => {
        console.log(`Executing: "${execCommand}"`);
        const commandParts = execCommand.split(' ');
        const command = commandParts.shift();
        const proc = cp.spawn(command, commandParts);

        proc.once('exit', (code, signal) => {
            resolve(execCommand);
        });
        proc.stdout.on('data', (x) => process.stdout.write(x));
        proc.stderr.on('data', (x) => process.stderr.write(x));
    });

export default { spawn, exec, execSpawn };
