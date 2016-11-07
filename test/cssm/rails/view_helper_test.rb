require 'test_helper'

describe CSSM::Rails::ViewHelper, :capybara do
  include CSSM::Rails::ViewHelper

  before do
    visit page_path
  end

  describe '.scssm' do
    it { page.must_have_selector cssms('event', 'title') }
  end

  describe '.css' do
    it { page.must_have_selector '.default' }
    it { page.must_have_selector cssms('default', 'default') }
  end

  describe 'nested' do
    it { page.must_have_selector cssms('test', 'heading') }
  end
end
