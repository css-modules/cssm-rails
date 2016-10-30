require 'execjs'

module Execjs
  module Async

    # extend from nodes external runtime context, and
    # overwrite compile to use the async source.
    class Context < ExecJS::ExternalRuntime::Context
      ASYNC_SOURCE = <<-'JAVASCRIPT'
        (function(program, execJS, module, exports, require) { execJS(program) })(function(callback, module, exports, require, console) { #{source}
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
                  print('["err"]');
                }
              }
            });
          } catch (err) {
            print(JSON.stringify(['err', '' + err]));
          }
        });
      JAVASCRIPT

      def compile(source)
        ASYNC_SOURCE.dup.tap do |output|
          output.sub!('#{source}') do
            source
          end
          output.sub!('#{encoded_source}') do
            encoded_source = encode_unicode_codepoints(source)
            MultiJson.encode("(function(){ #{encoded_source} })()")
          end
          output.sub!('#{json2_source}') do
            IO.read(ExecJS.root + "/support/json2.js")
          end
        end
      end
    end

    def compile_async(source)
      Context.new(self, source)
    end
  end

  ExecJS::Runtimes::Node.singleton_class.send(:include, Async)

  ExecJS.module_eval do
    def self.compile_async(source)
      runtime.compile_async(source)
    end
  end
end
