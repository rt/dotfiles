/* eslint-disable max-len */

const port = process.env.PORT || 3000;
const ip = process.env.IP || '0.0.0.0';

export default {
    ip: ip,
    port: port,
    auth: {
        jwt: { secret: process.env.JWT_SECRET || 'PebbleFields/Skeleton' },
    },
};
