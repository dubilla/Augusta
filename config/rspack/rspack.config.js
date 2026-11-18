const fs = require('fs')
const path = require('path')
const { generateRspackConfig } = require('shakapacker/rspack')
const { rspack } = require('@rspack/core')

const config = generateRspackConfig()

// Shakapacker's rspack setup gives neither SWC nor the LightningCSS minimizer any
// browser targets, so both would emit the newest syntax regardless of what we
// support. Point both at .browserslistrc.
const browserslist = fs
  .readFileSync(path.resolve(__dirname, '../../.browserslistrc'), 'utf8')
  .split('\n')
  .map((line) => line.replace(/#.*/, '').trim())
  .filter(Boolean)

let swcRules = 0
for (const rule of config.module.rules) {
  for (const use of [].concat(rule.use || [])) {
    if (use.loader === 'builtin:swc-loader') {
      use.options = { ...use.options, env: { targets: browserslist } }
      swcRules += 1
    }
  }
}
if (swcRules === 0) throw new Error('rspack.config.js: no builtin:swc-loader rule found to target')

if (config.optimization && config.optimization.minimizer) {
  let cssMinimizers = 0
  config.optimization.minimizer = config.optimization.minimizer.map((minimizer) => {
    if (!(minimizer instanceof rspack.LightningCssMinimizerRspackPlugin)) return minimizer
    cssMinimizers += 1
    return new rspack.LightningCssMinimizerRspackPlugin({ minimizerOptions: { targets: browserslist } })
  })
  if (cssMinimizers === 0) throw new Error('rspack.config.js: no LightningCSS minimizer found to target')
}

module.exports = config
