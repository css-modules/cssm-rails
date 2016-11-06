module CSSMRails
  module ViewHelper
    def cssm(asset_name, cls)
      # TODO: shall we calculate digest of that file?
      # Rails.cache.fetch(['cssm-rails', asset_name, cls].map(&:to_s).join('-')) do
        path = find_asset(asset_name)
        CSSMRails.process(File.read(path), from: path).export_tokens[cls.to_s]
      # end
    end

    private

    def find_asset(asset_name)
      asset_paths.flat_map do |path|
        Dir.glob("#{path}/#{asset_name}.{css,sass,scss}")
      end.first
    end

    def asset_paths
      @asset_paths ||= Rails.application.config.assets.paths
    end
  end
end
