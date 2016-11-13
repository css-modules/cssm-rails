require 'test_helper'

describe CSSM::Rails::Processor do
  let(:filename) { 'test.cssm' }
  let(:path) { File.join(SAMPLE_DIR, filename) }
  let(:css) { File.read(path) }

  it 'process CSS' do
    CSSM::Rails.process(css, from: path).must_be_kind_of CSSM::Rails::Result
  end

  describe 'Result' do
    let(:result) { CSSM::Rails.process(css, from: path) }

    it 'transforms the class names' do
      result.injectable_source.must_include ".test_background_s10oz {\n  background: yellow;\n}\n"
      result.injectable_source.must_include ".test_title_yzy5m {\n  color: red;\n}\n"
    end

    describe 'local composes: directive' do
      it 'generates export tokens' do
        result.export_tokens['title'].must_equal 'test_title_yzy5m test_background_s10oz'
      end
    end

    describe 'cross-file composes: directive' do
      it 'generates export tokens' do
        result.export_tokens['heading'].must_equal 'test_heading_3wdId common_bold_1B60t'
      end
    end
  end
end
