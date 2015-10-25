var Core = require('css-modules-loader-core')
var core = new Core()

window.CSSM = {
  compile: function (src, pathName) {
    var dummyPathFetcher = function () {
      return {}
    }
    return core.load(src, pathName, dummyPathFetcher)
  }
}
