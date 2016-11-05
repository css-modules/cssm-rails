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
      output = filename.chomp(File.extname(filename)) + '.scssm'
      result = @processor.process(css, from: filename, to: output)

      result.to_s
    end

    def self.install(env)
      # env.register_mime_type('text/cssm', extensions: %w(.scssm .scss.m))
      if ::Sprockets::VERSION.to_f < 4
        env.register_postprocessor('text/css', ::CSSMRails::Sprockets)
      else
        env.register_bundle_processor('text/css', ::CSSMRails::Sprockets)
      end
    end

    # Register postprocessor in Sprockets depend on issues with other gems
    def self.uninstall(env)
      if ::Sprockets::VERSION.to_f < 4
        env.unregister_postprocessor('text/css', ::CSSMRails::Sprockets)
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
