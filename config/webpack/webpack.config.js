// Shakapacker 8 single-config entrypoint (replaces the webpacker-5
// environment.js + per-env files). generateWebpackConfig() returns the base
// config for the current NODE_ENV, already wired for babel + dart-sass + the
// project's postcss.config.js. We only merge the app-specific bits on top.
const { generateWebpackConfig, merge } = require('shakapacker')
const webpack = require('webpack')

const customConfig = {
  plugins: [
    // Expose jQuery globally (some views/plugins rely on $ / jQuery).
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery'
    })
  ]
}

module.exports = merge(generateWebpackConfig(), customConfig)
