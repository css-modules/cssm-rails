module CSSMRails
  module ViewHelper
    def cssm(path_string)
      path = path_string.split(':')
      asset = Rails.application.assets[path.first]
      uri = URI.parse(asset.uri)
      file = File.read(uri.path)
      CSSMRails.process(file, from: asset.logical_path).export_tokens[path.last]
    end
  end
end
