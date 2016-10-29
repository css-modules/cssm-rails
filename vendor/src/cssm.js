var Core = require('css-modules-loader-core')
var core = new Core()

var g;

if (typeof window !== "undefined") {
    g = window
} else if (typeof global !== "undefined") {
    g = global
} else if (typeof self !== "undefined") {
    g = self
} else {
    g = this
}

g.CSSM = {
    compile: function(src, pathName) {
        var dummyPathFetcher = function() {
            return {}
        }
        return core.load(src, pathName, dummyPathFetcher)
    }
}
