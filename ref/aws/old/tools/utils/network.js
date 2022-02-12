import os from 'os';

export const getExternIpAddresses = () => {
    return new Promise((resolve, reject) => {

        var ifaces = os.networkInterfaces();
        const ipAddresses = [];

        for (let ifname of Object.keys(ifaces)) {
            var alias = 0;

            for (let iface of ifaces[ifname]) {
                if ('IPv4' !== iface.family || iface.internal !== false) {
                    // skip over internal (i.e. 127.0.0.1) and non-ipv4 addresses
                    continue;
                }

                if (alias >= 1) {
                    // this single interface has multiple ipv4 addresses
                    console.log(ifname + ':' + alias, iface.address);
                    ipAddresses.push(iface.address);
                } else {
                    // this interface has only one ipv4 adress
                    ipAddresses.push(iface.address);
                    console.log(ifname, iface.address);
                }
                ++alias;
            };
        };

        resolve(ipAddresses);
    });
};

export default { getExternIpAddresses };
