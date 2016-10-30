module CSSMRails
  class Result < Struct.new(:injectable_source, :export_tokens)
    def to_s
      injectable_source
    end
  end
end
