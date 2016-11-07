module CSSM
  module Rails
    class Asset < Struct.new(:name, :options)
      def initialize(name, options = {})
        super(name, options)
      end

      def path
        @path ||= paths.flat_map do |path|
          Dir.glob("#{path}/#{name}.{#{extensions.join(',')}}")
        end.first
      end

      def css
        @css ||= File.read(path)
      end

      def digest
        @digest ||= Digest::MD5.hexdigest(css)
      end

      private

      def extensions
        options.fetch :extensions, %w(css sass scss)
      end

      def paths
        @paths ||= ::Rails.application.config.assets.paths
      end
    end
  end
end
