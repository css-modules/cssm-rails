module CSSMRails
  autoload :Sprockets, 'cssm-rails/sprockets'

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

require_relative 'cssm-rails/processor'
require_relative 'cssm-rails/result'

require_relative 'cssm-rails/railtie' if defined?(Rails)

require_relative 'cssm-rails/version'
