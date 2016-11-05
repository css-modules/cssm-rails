// this file needs to be updated to support async callback
// see https://github.com/tomasc/cssm-rails/blob/master/lib/execjs/async.rb#L9

(function(program, execJS) { execJS(program) })(function(callback, global, process, module, exports, require, console, setTimeout, setInterval, clearTimeout, clearInterval, setImmediate, clearImmediate) {
  #{source}
}, function(program) {
  var output, print = function(string) {
    process.stdout.write('' + string);
  };
  try {
    program(function(result){
      if (typeof result == 'undefined' && result !== null) {
        print('["ok"]');
      } else {
        try {
          print(JSON.stringify(['ok', result]));
        } catch (err) {
          print(JSON.stringify(['err', '' + err, err.stack]));
        }
      }
    });

    print(JSON.stringify(['ok']));
  } catch (err) {
    this.process = __process__;
    print(JSON.stringify(['err', '' + err, err.stack]));
  }
});
