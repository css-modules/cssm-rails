module CSSM
  module Rails
    module ViewHelper
      def cssm(asset_name, cls)
        asset = cssm_asset(asset_name)
        cache_key = ['cssm', asset.digest, cls].join('-')

        ::Rails.cache.fetch(cache_key) do
          result = CSSM::Rails.process(asset.css, from: asset.path)
          result.export_tokens.fetch(cls.to_s, cls)
        end
      end

      def cssms(asset_name, cls)
        cssm(asset_name, cls).split(/\s+/).map { |i| ".#{i}" }.join
      end

      private

      def cssm_asset(asset_name)
        @cssm_asset ||= {}
        @cssm_asset[asset_name] ||= Asset.new(asset_name)
      end
    end
  end
end
