module CSSM
  module Rails
    class Processor < Struct.new(:params)
      BUNDLE_JS_PATH = File.join(ROOT_PATH, '../..', 'vendor/bundle.js')

      def initialize(params = {})
        super(params)
      end

      def process(css, opts = {})
        filename = opts.fetch(:from, nil)

        bundle_js_args = Shellwords.escape(BUNDLE_JS_PATH)
        css_arg = Shellwords.escape(css)
        filename_arg = Shellwords.escape(filename.to_s)

        result = JSON.parse `node #{bundle_js_args} #{css_arg} #{filename_arg}`

        Result.new(result['injectableSource'], result['exportTokens'])
      end
    end
  end
end
