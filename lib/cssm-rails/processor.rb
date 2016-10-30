require 'execjs'
require 'execjs/async'

module CSSMRails
  class Processor < Struct.new(:params)
    def initialize(params = {})
      super(params)
    end

    def process(css, opts = {})
      filename = opts.fetch(:from, nil)
      result = runtime.call('run', css, filename)
      Result.new(result['injectableSource'], result['exportTokens'])
    end

    private

    def runtime
      @runtime ||= ExecJS.compile_async(build_js)

      # ready for ExecJS 2.7
      # ExecJS.runtime = ExecJS::ExternalRuntime.new(
      #   name: "Node.js (V8)",
      #   command:     ["nodejs", "node"],
      #   runner_path: File.join(File.dirname(__FILE__), '../execjs/support/node_async_runner.js'),
      #   encoding:    'UTF-8'
      # )
      #
      # @runtime ||= ExecJS.compile(build_js)

    end

    def read_js
      @@js ||= Pathname(File.dirname(__FILE__)).join('../../vendor/bundle.js').read
    end

    def build_js
      [read_js, process_proxy].join(';')
    end

    def process_proxy
      <<-JS
        var run = function(source, filename) {
          postcss_modules(source, filename).then(function(res) { callback(res) });
        }
      JS
    end
  end
end
