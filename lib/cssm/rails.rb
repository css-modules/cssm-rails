module CSSM
  module Rails
    ROOT_PATH = __dir__

    autoload :Sprockets, 'cssm/rails/sprockets'

    def self.process(css, opts = {})
      params = {}
      processor(params).process(css, opts)
    end

    def self.install(assets, params = {})
      Sprockets.register_processor(processor(params))
      Sprockets.install(assets)
    end

    def self.uninstall(assets)
      Sprockets.uninstall(assets)
    end

    def self.processor(params = {})
      Processor.new(params)
    end
  end
end

require_relative 'rails/processor'
require_relative 'rails/result'
require_relative 'rails/view_helper'

require_relative 'rails/railtie' if defined?(Rails)

require_relative 'rails/version'
