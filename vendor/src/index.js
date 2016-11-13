var Core = require('css-modules-loader-core');
var genericNames = require('generic-names')

var extractImports = require('postcss-modules-extract-imports');
var scope = require('postcss-modules-scope');
var values = require('postcss-modules-values');

// var fs = require('fs');
var path = require('path');
var glob = require('glob');
var cached = {};

module.exports = function(css, pathName) {
  // TODO: the template should be configurable
  var template = "[name]_[local]_[hash:base64:5]"
  Core.scope.generateScopedName = genericNames(template, { context: process.cwd() })

  var trace = 0;
  // var core = new Core([values, extractImports, scope]);
  var core = new Core();

  function pathFetcher(file, relativeTo, depTrace) {
    file = file.replace(/^["']|["']$/g, "")
    var dir = path.dirname(relativeTo)
    var sourcePath = glob.sync(path.join(dir, file))[0]
    if (!sourcePath) {
      console.error('no sourcePath', dir, file);
    }

    return new Promise(function(resolve, reject) {
      var _cached = cached[sourcePath];
      if (_cached) {
        return resolve(_cached.exportTokens);
      }

      fs.readFile(sourcePath, 'utf-8', function(error, sourceString) {
        if (error) { return reject(error); }
        core
          .load(sourceString, sourcePath, ++trace, pathFetcher)
          .then(function(result) {
            cached[sourcePath] = result;
            resolve(result.exportTokens);
          })
          .catch(reject);
      });
    });
  }

  return core.load(css, pathName, ++trace, pathFetcher)
}

var args = process.argv.slice(2);
module.exports(args[0], args[1]).then(
  function(result) {
    process.stdout.write(JSON.stringify(result))
  }
)
