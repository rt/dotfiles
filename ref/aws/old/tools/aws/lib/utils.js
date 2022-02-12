import { exec } from '../../lib/cp';

const isDebug = process.env.DEBUG;

/**
 * If you want to build scripts using aws cli
 * @param {string} command
 */
export async function cliExec(command) {
    if (isDebug) {
        //process.stdout.write(`executing ${command} \n`);
        console.log((`executing ${command}`));  //same thing, adds the new line
    }

    const proc = await exec(command);

    if (isDebug) {
        process.stdout.write(proc.stdout);
    }
    process.stderr.write(proc.stderr);
    return proc;
}
