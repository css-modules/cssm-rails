require 'test_helper'

describe CSSMRails::Processor do
  let(:dir) { Pathname(__FILE__).dirname }
  let(:filename) { '../samples/test.css' }
  let(:path) { dir.join(filename) }
  let(:css) { path.read }

  it 'process CSS' do
    CSSMRails.process(css, from: path).must_be_kind_of CSSMRails::Result
  end

  describe 'Result' do
    let(:result) { CSSMRails.process(css, from: path) }

    it 'process CSS' do
      result.injectable_source.must_include ".test_background_aEwdQ {\n  background: yellow;\n}\n"
      result.injectable_source.must_include ".test_title_jz0yg {\n  color: red;\n}\n"
    end

    describe 'local composes: directive' do
      it 'generates export tokens' do
        result.export_tokens['title'].must_equal('test_title_jz0yg test_background_aEwdQ')
      end
    end

    describe 'cross-file composes: directive' do
      it 'generates export tokens' do
        result.export_tokens['heading'].must_equal('test_heading_BTR6p common_bold_1msV9')
      end
    end
  end
end
