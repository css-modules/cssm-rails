module CSSM
  module Rails
    class Result < Struct.new(:injectable_source, :export_tokens)
      def initialize(injectable_source, export_tokens)
        super(injectable_source, export_tokens)
      end

      def to_s
        injectable_source
      end
    end
  end
end
