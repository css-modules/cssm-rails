var Core = require('css-modules-loader-core');
var stringHash = require('string-hash')
var genericNames = require('generic-names')
// var FileSystemLoader = require('css-modules-loader-core/lib/file-system-loader');

module.exports = function(css, pathName) {
  // TODO: the template shuold be configurable
  var template = "[name]_[local]_[hash:base64:5]"
  Core.scope.generateScopedName = genericNames(template, { context: process.cwd() })

  var core = new Core()
  
  // TODO: provide proper pathFetcher
  var dummyPathFetcher = function () { return {} }
  return core.load(css, pathName, dummyPathFetcher)
}
