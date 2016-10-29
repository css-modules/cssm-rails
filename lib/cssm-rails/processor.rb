require 'pathname'
require 'execjs/async'
require 'json'

module CSSMRails
  class Processor
    def initialize(params = {})
      @params = params || {}
    end

    # Process `css` and return result.
    #
    # Options can be:
    # * `from` with input CSS file name. Will be used in error messages.
    # * `to` with output CSS file name.
    # * `map` with true to generate new source map or with previous map.
    def process(css, _opts = {})
      result = runtime.call('process', css, 'inline.css')

      Result.new(result['css'], result['map'])
    end

    private

    # def params_with_browsers(from = nil)
    #   unless from
    #     from = if defined? Rails && Rails.respond_to?(:root) && Rails.root
    #              Rails.root.join('app/assets/stylesheets').to_s
    #            else
    #              '.'
    #            end
    #   end
    #
    #   params = @params
    #   if !params.key?(:browsers) && from
    #     config = find_config(from)
    #     if config
    #       params = params.dup
    #       params[:browsers] = parse_config(config)
    #     end
    #   end
    #
    #   params
    # end

    # # Convert params to JS string and add browsers from Browserslist config
    # def js_params
    #   '{ ' +
    #     params_with_browsers.map { |k, v| "#{k}: #{v.inspect}" }.join(', ') +
    #     ' }'
    # end

    # # Convert ruby_options to jsOptions
    # def convert_options(opts)
    #   converted = {}
    #
    #   opts.each_pair do |name, value|
    #     if name =~ /_/
    #       name = name.to_s.gsub(/_\w/) { |i| i.delete('_').upcase }.to_sym
    #     end
    #     value = convert_options(value) if value.is_a? Hash
    #     converted[name] = value
    #   end
    #
    #   converted
    # end

    # # Try to find Browserslist config
    # def find_config(file)
    #   path = Pathname(file).expand_path
    #
    #   while path.parent != path
    #     config = path.join('browserslist')
    #     return config.read if config.exist? && !config.directory?
    #     path = path.parent
    #   end
    #
    #   nil
    # end

    def runtime
      @runtime ||= ExecJS.compile(build_js)
    end

    def read_js
      @@js ||= Pathname(File.dirname(__FILE__)).join('../../vendor/cssm.js').read
    end

    def build_js
      ['var global = this', read_js, process_proxy].join(';')
    end

    def process_proxy
      <<-JS
        function process(source, filename) {
        }
      JS
    end
  end
end
