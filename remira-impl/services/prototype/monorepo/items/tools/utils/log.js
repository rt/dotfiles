export const log = (str) =>
    new Promise((resolve, reject) => {
        console.log(`\n---------- ${str} ----------\n`);
    });

export default { log };
