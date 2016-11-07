require 'sassc-rails'
require 'sprockets/railtie'

begin
  module CSSM
    module Rails
      class Railtie < ::Rails::Railtie
        config.cssm = ActiveSupport::OrderedOptions.new

        if config.respond_to?(:annotations)
          config.annotations.register_extensions("scssm", "sassm") { |annotation| /\/\/\s*(#{annotation}):?\s*(.*)$/ }
        end

        initializer :setup_sass, group: :all do |app|
          config.assets.configure do |env|
            if env.respond_to?(:register_transformer)
              env.register_transformer 'text/sass-modules', 'text/css', SassC::Rails::SassTemplate.new
              env.register_transformer 'text/scss-modules', 'text/css', SassC::Rails::ScssTemplate.new
            end

            if env.respond_to?(:register_engine)
              [
                ['.sassm', SassC::Rails::SassTemplate],
                ['.scssm', SassC::Rails::ScssTemplate]
              ].each do |engine|
                engine << { silence_deprecation: true } if ::Sprockets::VERSION.start_with?("3")
                env.register_engine(*engine)
              end
            end
          end
        end

        initializer :cssm_rails_view_helpers do
          ActionView::Base.send :include, CSSM::Rails::ViewHelper
        end

        if config.respond_to?(:assets) && !config.assets.nil?
          config.assets.configure do |env|
            CSSM::Rails.install(env, {})
          end
        else
          initializer :setup_cssm_rails, group: :all do |app|
            if defined? app.assets && !app.assets.nil?
              CSSM::Rails.install(app.assets, {})
            end
          end
        end
      end
    end
  rescue LoadError
  end
end
