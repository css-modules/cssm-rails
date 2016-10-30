require 'test_helper'

describe CSSMRails do
  let(:dir) { Pathname(__FILE__).dirname }
  let(:filename) { 'test.scssm' }
  let(:css) { dir.join("samples/#{filename}").read }

  it 'process CSS' do
    CSSMRails.process(css).must_be_kind_of CSSMRails::Result
  end

  it 'process CSS' do
    result = CSSMRails.process(css, from: filename)
    result.injectable_source.must_equal ".test_title_199rY { color: red; }\n"
  end

  it 'generates export tokens' do
    result = CSSMRails.process(css, from: filename)
    result.export_tokens.must_equal('title' => 'test_title_199rY')
  end
end
