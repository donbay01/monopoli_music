'use strict';

/**
 * Stream song
 */
if (!process.env.FUNCTION_NAME || process.env.FUNCTION_NAME === 'newTrackStream') {
    exports.newTrackStream = require('./src/track').newTrackStream;
}