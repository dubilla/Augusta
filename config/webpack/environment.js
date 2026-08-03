const { environment } = require('@rails/webpacker')
const webpack = require('webpack')
const path = require('path')

environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery'
}))

// Path to the project's postcss.config.js (this file lives in config/webpack/).
const postcssConfigPath = path.resolve(__dirname, '../../postcss.config.js')

// Webpacker 5.2.1 was written for postcss-loader v3 and node-sass. We run
// postcss-loader v4 (required for the postcss 8 plugin chain) and dart-sass,
// so rewrite each style rule's loader options to the shapes those expect.
;['css', 'sass', 'moduleCss', 'moduleSass'].forEach((name) => {
  const loader = environment.loaders.get(name)
  if (!loader) return
  loader.use.forEach((entry) => {
    if (entry.loader === 'postcss-loader') {
      // postcss-loader v4 replaced the v3 `config: { path }` option with `postcssOptions`.
      entry.options = {
        sourceMap: true,
        postcssOptions: { config: postcssConfigPath }
      }
    }
    if (entry.loader === 'sass-loader') {
      // Use dart-sass instead of the deprecated, uncompilable node-sass.
      entry.options.implementation = require('sass')
    }
  })
})

module.exports = environment
