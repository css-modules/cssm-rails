var Core = require('css-modules-loader-core');
var stringHash = require('string-hash')
var genericNames = require('generic-names')

module.exports = function(css, pathName) {
  // function generateScopedName(name, filename, css) {
  //   const i           = css.indexOf(`.${ name }`);
  //   const lineNumber  = css.substr(0, i).split(/[\r\n]/).length;
  //   const hash        = stringHash(css).toString(36).substr(0, 5);
  //
  //   return `_${ name }_${ hash }_${ lineNumber }`;
  // }

  // Core.scope.generateScopedName = generateScopedName
  Core.scope.generateScopedName =  genericNames("[name]_[local]_[hash:base64:5]", { context: process.cwd() })

  var core = new Core()

  var dummyPathFetcher = function () {
    return {}
  }
  return core.load(css, pathName, dummyPathFetcher)
}
