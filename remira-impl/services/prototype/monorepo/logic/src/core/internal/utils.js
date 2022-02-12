// import LogData from '../data/appengine/log';
// import Log from '../models/log';

export function apiEnvelope(fn) {
    return new Promise((resolve, reject) => {
        resolve(fn());
    });
}

/**
 * Rpc encapsulate
 *
 * Error logging
 * - log all errors
 *
 * Performance monitoring
 * - ave
 * - standar deviation to log
 *
 * @param {object} data : data for the rpc (ave, etc)  ... or do we keep this local?
 * ISSUES:
 * - getting / setting the data is going to be an issue with stateless servers
 *   send errors
 *   send fixed value limits ... every deploy
 *   or in files
 *   or it's just the current value
 *
 *   or via thread context where you store to thread and collect on output.
 */
export function monitor(fn, params, sessionId, data) {
    // monitor all rpcs
    // - api can pass sessionId (todo: this means api needs to call monitor not the function
    // or monitor(sessionId).then(someFunction) ...
    // or it just catches/does perf analysis
    //
    // encapsulate return
    // {
    //   data: functionReturn,
    //   meta:
    //   }
    //
    //
    // cross cutting each method to log to thread?
    //
    //
    // timeStart
    try {
        fn(...params);
    } catch (e) {
        // Error Logging
        // log(sessionId, e);
    }
    // timeEnd
    if (passesConditionToLog(config, data, timeStart, timeEnd)) {
    }
}

function passesConditionToLog(config, data, timeStart, timeEnd) {
    // Performance Logging: slower by x of average
    //
    // every once in awhile to get average data that is not an error (random)
    return false;
}
