var Core = require('css-modules-loader-core');
var genericNames = require('generic-names')
// var fs = require('fs');

module.exports = function(css, pathName) {
  // TODO: the template should be configurable
  var template = "[name]_[local]_[hash:base64:5]"
  Core.scope.generateScopedName = genericNames(template, { context: process.cwd() })

  var trace = 0;
  var core = new Core()
  function pathFetcher(file, relativeTo, depTrace) {
    // return new Promise((resolve, reject) => {
    //   resolve({});
    // });
    // var sourcePath = '/Users/tomascelizna/Work/Code/gems/cssm-rails/test/samples/common.css';
    return new Promise((resolve, reject) => {
      // readFile(sourcePath, 'utf-8', (error, sourceString) => {
        core
          .load(".bold { font-weight: bold; }", "common.css", ++trace, pathFetcher)
          .then(result => {
            resolve(result.exportTokens);
            // resolve('foo bar');
          })
          .catch(reject);
      });
    // });
  }

  return core.load(css, pathName, trace, pathFetcher)
}
