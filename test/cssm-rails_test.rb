require 'test_helper'

describe CSSMRails do
  let(:dir) { Pathname(__FILE__).dirname }
  let(:css) { dir.join('samples/test.scss').read }

  it 'process CSS' do
    CSSMRails.process(css).must_be_kind_of CSSMRails::Result
  end

  it "process CSS" do
    css = ".title { color: red; }"
    result = CSSMRails.process(css)
    result.css.must_equal 'foo'
  end
end
