module CSSMRails
  module ViewHelper
    # FIXME: this does not work in production
    # refactor to rely on Rails.application.config.assets.paths
    #
    # TODO: add cache
    def cssm(path_string)
      path = path_string.split(':')
      asset = Rails.application.assets[path.first]
      uri = URI.parse(asset.uri)
      file = File.read(uri.path)
      CSSMRails.process(file, from: asset.logical_path).export_tokens[path.last]
    end
  end
end
