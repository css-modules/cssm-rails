require 'test_helper'

describe CSSMRails::Processor do
  let(:dir) { Pathname(__FILE__).dirname }
  let(:filename) { 'test.scss' }
  let(:css) { dir.join("../samples/#{filename}").read }

  it 'process CSS' do
    CSSMRails.process(css).must_be_kind_of CSSMRails::Result
  end

  describe 'Result' do
    let(:result) { CSSMRails.process(css, from: filename) }
    it 'process CSS' do
      result.injectable_source.must_include ".test_background_1_AFK {\n  background: yellow;\n}\n"
      result.injectable_source.must_include ".test_title_25Esx {\n  color: red;\n}\n"
    end

    describe 'local composes: directive' do
      it 'generates export tokens' do
        result.export_tokens['title'].must_equal('test_title_25Esx test_background_1_AFK')
      end
    end

    describe 'cross-file composes: directive' do
      it 'generates export tokens' do
        result.export_tokens['heading'].must_equal('test_heading_vbGaC common_bold_22mR6')
      end
    end
  end
end
