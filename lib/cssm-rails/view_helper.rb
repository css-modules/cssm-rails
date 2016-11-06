module CSSMRails
  module ViewHelper
    # FIXME: this does not work in production
    # refactor to rely on Rails.application.config.assets.paths
    #
    def cssm(asset_name, cls)
      # TODO: shall we calculate digest of that file?
      # Rails.cache.fetch(['cssm-rails', asset_name, cls].map(&:to_s).join('-')) do
        asset = Rails.application.assets[asset_name]
        # TODO: return unless specific extension
        uri = URI.parse(asset.uri)
        file = File.read(uri.path)
        CSSMRails.process(file, from: asset.logical_path).export_tokens[cls.to_s]
      # end
    end
  end
end
