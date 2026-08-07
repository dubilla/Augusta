module.exports = function (api) {
  // Shakapacker 8's default babel preset (preset-env + class-properties +
  // transform-runtime etc.). We layer @babel/preset-react on top for JSX.
  const defaultConfigFunc = require('shakapacker/package/babel/preset.js')
  const resultConfig = defaultConfigFunc(api)
  const isProductionEnv = api.env('production')

  const reactConfig = {
    presets: [
      // Classic runtime — the .jsx files `import React` explicitly (React 17).
      [
        '@babel/preset-react',
        {
          development: !isProductionEnv,
          useBuiltIns: true
        }
      ]
    ],
    plugins: [
      isProductionEnv && [
        'babel-plugin-transform-react-remove-prop-types',
        { removeImport: true }
      ]
    ].filter(Boolean)
  }

  return {
    presets: [...resultConfig.presets, ...reactConfig.presets],
    plugins: [...resultConfig.plugins, ...reactConfig.plugins]
  }
}
