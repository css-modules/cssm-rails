require 'test_helper'

describe CSSM::Rails::Processor do
  let(:filename) { 'test.css' }
  let(:path) { File.join(SAMPLE_DIR, filename) }
  let(:css) { File.read(path) }

  it 'process CSS' do
    CSSM::Rails.process(css, from: path).must_be_kind_of CSSM::Rails::Result
  end

  describe 'Result' do
    let(:result) { CSSM::Rails.process(css, from: path) }

    describe 'global by default' do
      let(:filename) { '../samples/default.css' }

      it 'preserves class names' do
        result.injectable_source.must_include ".default {\n  color: blue;\n}\n"
        result.export_tokens['default'].must_be_nil
      end
    end

    describe ':local directive' do
      it 'transforms the class names' do
        result.injectable_source.must_include ".test_background_aEwdQ {\n  background: yellow;\n}\n"
        result.injectable_source.must_include ".test_title_jz0yg {\n  color: red;\n}\n"
      end
    end

    describe 'local composes: directive' do
      it 'generates export tokens' do
        result.export_tokens['title'].must_equal 'test_title_jz0yg test_background_aEwdQ'
      end
    end

    describe 'cross-file composes: directive' do
      it 'generates export tokens' do
        result.export_tokens['heading'].must_equal 'test_heading_BTR6p common_bold_1msV9'
      end
    end
  end
end
