const { environment } = require('@rails/webpacker')

// Hack for PostCSS 8 and Webpacker
const css = environment.loaders.get('css');
const sass = environment.loaders.get('sass');
const postCssConfig = css.use.find(u => u.loader === 'postcss-loader');
const postSassConfig = sass.use.find(u => u.loader === 'postcss-loader');
if (postCssConfig) {
  delete postCssConfig.options.config;
}
if (postSassConfig) {
  delete postCssConfig.options.config;
}

const webpack = require('webpack');
environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery'
}));

module.exports = environment
