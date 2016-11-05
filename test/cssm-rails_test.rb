require 'test_helper'

describe CSSMRails do
  let(:dir) { Pathname(__FILE__).dirname }
  let(:filename) { 'test.scss' }
  let(:css) { dir.join("samples/#{filename}").read }

  it 'process CSS' do
    CSSMRails.process(css).must_be_kind_of CSSMRails::Result
  end

  it 'process CSS' do
    result = CSSMRails.process(css, from: filename)
    result.injectable_source.must_include ".test_background_1_AFK {\n  background: yellow;\n}\n"
    result.injectable_source.must_include ".test_title_25Esx {\n  color: red;\n}\n"
  end

  it 'generates export tokens' do
    result = CSSMRails.process(css, from: filename)
    result.export_tokens.must_equal('background' => 'test_background_1_AFK', 'title' => 'test_title_25Esx test_background_1_AFK')
  end
end
