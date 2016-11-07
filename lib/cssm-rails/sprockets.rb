require 'pathname'

module CSSMRails
  class Sprockets
    def self.register_processor(processor)
      @processor = processor
    end

    def self.call(input)
      filename = input[:filename]
      source = input[:data]
      run(filename, source)
    end

    def self.run(filename, css)
      result = @processor.process(css, from: filename)
      result.to_s
    end

    def self.install(env)
      if ::Sprockets::VERSION.to_f < 4
        env.register_preprocessor('text/css', ::CSSMRails::Sprockets)
      else
        env.register_bundle_processor('text/css', ::CSSMRails::Sprockets)
      end
    end

    # Register postprocessor in Sprockets depend on issues with other gems
    def self.uninstall(env)
      if ::Sprockets::VERSION.to_f < 4
        env.unregister_preprocessor('text/css', ::CSSMRails::Sprockets)
      else
        env.unregister_bundle_processor('text/css', ::CSSMRails::Sprockets)
      end
    end

    # Sprockets 2 API new and render
    def initialize(filename)
      @filename = filename
      @source = yield
    end

    # Sprockets 2 API new and render
    def render(_, _)
      self.class.run(@filename, @source)
    end
  end
end
