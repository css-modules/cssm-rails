require 'yaml'

begin
  module CSSMRails
    class Railtie < ::Rails::Railtie
      if config.respond_to?(:assets) && !config.assets.nil?
        config.assets.configure do |env|
          CSSMRails.install(env, {})
        end
      else
        initializer :setup_cssm_rails, group: :all do |app|
          if defined? app.assets && !app.assets.nil?
            CSSMRails.install(app.assets, {})
          end
        end
      end
    end
  end
rescue LoadError
end
