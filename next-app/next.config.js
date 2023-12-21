/** @type {import('next').NextConfig} */

const path = require('path');

const nextConfig = {
    async redirects() {
        return [
            {
                source: '/',
                destination: '/home',
                permanent: true
            }
        ];
    },
    sassOptions: {
        includePaths: [path.join(__dirname, 'sass')]
    }
};

module.exports = nextConfig;
