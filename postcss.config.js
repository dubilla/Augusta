module.exports = {
  plugins: [
    // postcss-import must run first so `@import "tailwindcss/base"` etc. are
    // inlined before webpack's css-loader tries to resolve them as modules.
    require('postcss-import'),
    require('tailwindcss'),
    // autoprefixer is applied by postcss-preset-env below (configured via its
    // `autoprefixer` option), so it is not listed standalone here.
    require('postcss-flexbugs-fixes'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    })
  ]
}
