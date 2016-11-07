module CSSM
  module Rails
    module ViewHelper
      # TODO: Rails.cache.fetch?
      # we'd need asset difest not only of the file but of all files referred using `composes`
      def cssm(asset_name, cls)
        @cssm ||= {}
        @cssm[asset_name] ||= {}
        @cssm[asset_name][cls] ||= begin
          path = find_asset(asset_name)
          CSSM::Rails.process(File.read(path), from: path).export_tokens[cls.to_s] || cls
        end
      end

      def cssms(asset_name, cls)
        cssm(asset_name, cls).split(/\s+/).map { |i| ".#{i}" }.join
      end

      private

      def find_asset(asset_name)
        asset_paths.flat_map do |path|
          Dir.glob("#{path}/#{asset_name}.{css,sass,scss}")
        end.first
      end

      def asset_paths
        @asset_paths ||= ::Rails.application.config.assets.paths
      end
    end
  end
end
