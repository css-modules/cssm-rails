module CSSMRails
  class Processor < Struct.new(:params)
    def initialize(params = {})
      super(params)
    end

    def process(css, opts = {})
      filename = opts.fetch(:from, nil)

      bundle_js_args = Shellwords.escape(bundle_js_path.to_s)
      css_arg = Shellwords.escape(css)
      filename_arg = Shellwords.escape(filename.to_s)

      result = JSON.parse `node #{bundle_js_args} #{css_arg} #{filename_arg}`

      Result.new(result['injectableSource'], result['exportTokens'])
    end

    private

    def bundle_js_path
      Pathname(File.dirname(__FILE__)).join('../../vendor/bundle.js')
    end
  end
end
