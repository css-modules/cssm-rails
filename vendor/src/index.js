var Core = require('css-modules-loader-core');
var genericNames = require('generic-names')
// var fs = require('fs');
var path = require('path');
var glob = require('glob');
var cached = {};

module.exports = function(css, pathName) {
  // TODO: the template should be configurable
  var template = "[name]_[local]_[hash:base64:5]"
  Core.scope.generateScopedName = genericNames(template, { context: process.cwd() })

  var trace = 0;
  var core = new Core()

  function pathFetcher(file, relativeTo, depTrace) {
    file = file.replace(/^["']|["']$/g, "")
    let dir = path.dirname(relativeTo)
    let sourcePath = glob.sync(path.join(dir, file))[0]
    if (!sourcePath) {
      console.error('no sourcePath', dir, file);
    }

    return new Promise((resolve, reject) => {
      var _cached = cached[sourcePath];
      if (_cached) {
        return resolve(_cached.exportTokens);
      }

      fs.readFile(sourcePath, 'utf-8', (error, sourceString) => {
        if (error) { return reject(error); }
        core
          .load(sourceString, "common.css", ++trace, pathFetcher)
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

module.exports('.background { composes: bold from "./common.css"; background: yellow; }', '/Users/tomascelizna/Work/Code/gems/cssm-rails/test/samples/test.scss').then(
  function(result) {
    console.log(result);
  }
)
