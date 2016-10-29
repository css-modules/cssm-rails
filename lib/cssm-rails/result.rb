module CSSMRails
  class Result
    attr_reader :css
    attr_reader :map

    def initialize(css, map)
      @css = css
      @map = map
    end

    def to_s
      @css
    end
  end
end
