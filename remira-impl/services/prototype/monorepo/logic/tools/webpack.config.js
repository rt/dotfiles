import fs from 'fs';
import path from 'path';
import webpack from 'webpack';
import nodeExternals from 'webpack-node-externals';
import { BundleAnalyzerPlugin } from 'webpack-bundle-analyzer';
import overrideRules from './lib/overrideRules';
import pkg from '../package.json';

const ROOT_DIR = path.resolve(__dirname, '..');
const resolvePath = (...args) => path.resolve(ROOT_DIR, ...args);
const SRC_DIR = resolvePath('src');
const BUILD_DIR = resolvePath('build');

const isDebug = !process.argv.includes('--release');
const isVerbose = process.argv.includes('--verbose');
const isAnalyze =
    process.argv.includes('--analyze') || process.argv.includes('--analyse');

const reScript = /\.(js|jsx|mjs)$/;
const reStyle = /\.(css|less|styl|scss|sass|sss)$/;
const reImage = /\.(bmp|gif|jpg|jpeg|png|svg)$/;
const staticAssetName = isDebug
    ? '[path][name].[ext]?[hash:8]'
    : '[hash:8].[ext]';

// CSS Nano options http://cssnano.co/
const minimizeCssOptions = {
    discardComments: { removeAll: true },
};

//
// Common configuration chunk to be used for both
// client-side (client.js) and server-side (server.js) bundles
// -----------------------------------------------------------------------------

const config = {
    context: ROOT_DIR,

    mode: isDebug ? 'development' : 'production',

    output: {
        path: resolvePath(BUILD_DIR, 'public/assets'),
        publicPath: '/assets/',
        pathinfo: isVerbose,
        filename: isDebug ? '[name].js' : '[name].[chunkhash:8].js',
        chunkFilename: isDebug
            ? '[name].chunk.js'
            : '[name].[chunkhash:8].chunk.js',
        // Point sourcemap entries to original disk location (format as URL on Windows)
        devtoolModuleFilenameTemplate: (info) =>
            path.resolve(info.absoluteResourcePath).replace(/\\/g, '/'),
    },

    resolve: {
        // Allow absolute paths in imports, e.g. import Button from 'components/Button'
        // Keep in sync with .flowconfig and .eslintrc
        modules: ['node_modules', 'src'],
    },

    module: {
        // Make missing exports an error instead of warning
        strictExportPresence: true,

        rules: [
            // Rules for JS / JSX
            {
                test: reScript,
                include: [SRC_DIR, resolvePath('tools')],
                loader: 'babel-loader',
                options: {
                    // https://github.com/babel/babel-loader#options
                    cacheDirectory: isDebug,

                    // https://babeljs.io/docs/usage/options/
                    babelrc: false,
                    presets: [
                        // A Babel preset that can automatically determine the Babel plugins and polyfills
                        // https://github.com/babel/babel-preset-env
                        [
                            '@babel/preset-env',
                            {
                                targets: {
                                    browsers: pkg.browserslist,
                                },
                                forceAllTransforms: !isDebug, // for UglifyJS
                                modules: false,
                                useBuiltIns: false,
                                debug: false,
                            },
                        ],
                    ],
                    plugins: [],
                },
            },

            // Rules for images
            {
                test: reImage,
                oneOf: [
                    // Inline lightweight images into CSS
                    {
                        issuer: reStyle,
                        oneOf: [
                            // Inline lightweight SVGs as UTF-8 encoded DataUrl string
                            {
                                test: /\.svg$/,
                                loader: 'svg-url-loader',
                                options: {
                                    name: staticAssetName,
                                    limit: 4096, // 4kb
                                },
                            },

                            // Inline lightweight images as Base64 encoded DataUrl string
                            {
                                loader: 'url-loader',
                                options: {
                                    name: staticAssetName,
                                    limit: 4096, // 4kb
                                },
                            },
                        ],
                    },

                    // Or return public URL to image resource
                    {
                        loader: 'file-loader',
                        options: {
                            name: staticAssetName,
                        },
                    },
                ],
            },

            // Convert plain text into JS module
            {
                test: /\.txt$/,
                loader: 'raw-loader',
            },

            // Convert Markdown into HTML
            {
                test: /\.md$/,
                loader: path.resolve(__dirname, './lib/markdown-loader.js'),
            },

            // Return public URL for all assets unless explicitly excluded
            // DO NOT FORGET to update `exclude` list when you adding a new loader
            {
                exclude: [
                    reScript,
                    reStyle,
                    reImage,
                    /\.json$/,
                    /\.txt$/,
                    /\.md$/,
                ],
                loader: 'file-loader',
                options: {
                    name: staticAssetName,
                },
            },

            // Exclude dev modules from production build
            ...(isDebug
                ? []
                : [
                      {
                          test: resolvePath(
                              'node_modules/react-deep-force-update/lib/index.js'
                          ),
                          loader: 'null-loader',
                      },
                  ]),
        ],
    },

    // Don't attempt to continue if there are any errors.
    bail: !isDebug,

    cache: isDebug,

    // Specify what bundle information gets displayed
    // https://webpack.js.org/configuration/stats/
    stats: {
        cached: isVerbose,
        cachedAssets: isVerbose,
        chunks: isVerbose,
        chunkModules: isVerbose,
        colors: true,
        hash: isVerbose,
        modules: isVerbose,
        reasons: isDebug,
        timings: true,
        version: isVerbose,
    },

    // Choose a developer tool to enhance debugging
    // https://webpack.js.org/configuration/devtool/#devtool
    devtool: isDebug ? 'cheap-module-inline-source-map' : 'source-map',
};

//
// Configuration for the server-side bundle (server.js)
// -----------------------------------------------------------------------------

const serverConfig = {
    ...config,

    name: 'server',
    target: 'node',

    entry: {
        server: ['@babel/polyfill', './src/server.js'],
    },

    output: {
        ...config.output,
        path: BUILD_DIR,
        filename: '[name].js',
        chunkFilename: 'chunks/[name].js',
        libraryTarget: 'commonjs2',
    },

    // Webpack mutates resolve object, so clone it to avoid issues
    // https://github.com/webpack/webpack/issues/4817
    resolve: {
        ...config.resolve,
    },

    module: {
        ...config.module,

        rules: overrideRules(config.module.rules, (rule) => {
            // Override babel-preset-env configuration for Node.js
            if (rule.loader === 'babel-loader') {
                return {
                    ...rule,
                    options: {
                        ...rule.options,
                        presets: rule.options.presets.map((preset) =>
                            preset[0] !== '@babel/preset-env'
                                ? preset
                                : [
                                      '@babel/preset-env',
                                      {
                                          targets: {
                                              node: pkg.engines.node.match(
                                                  /(\d+\.?)+/
                                              )[0],
                                          },
                                          modules: false,
                                          useBuiltIns: false,
                                          debug: false,
                                      },
                                  ]
                        ),
                    },
                };
            }

            // Override paths to static assets
            if (
                rule.loader === 'file-loader' ||
                rule.loader === 'url-loader' ||
                rule.loader === 'svg-url-loader'
            ) {
                return {
                    ...rule,
                    options: {
                        ...rule.options,
                        emitFile: false,
                    },
                };
            }

            return rule;
        }),
    },

    externals: [
        './chunk-manifest.json',
        './asset-manifest.json',
        nodeExternals({
            whitelist: [reStyle, reImage],
        }),
    ],

    plugins: [
        // Define free variables
        // https://webpack.js.org/plugins/define-plugin/
        new webpack.DefinePlugin({
            'process.env.BROWSER': false,
            __DEV__: isDebug,
        }),

        // Adds a banner to the top of each generated chunk
        // https://webpack.js.org/plugins/banner-plugin/
        new webpack.BannerPlugin({
            banner: 'require("source-map-support").install();',
            raw: true,
            entryOnly: false,
        }),
    ],

    // Do not replace node globals with polyfills
    // https://webpack.js.org/configuration/node/
    node: {
        console: false,
        global: false,
        process: false,
        Buffer: false,
        __filename: false,
        __dirname: false,
    },
};

export default [serverConfig];
