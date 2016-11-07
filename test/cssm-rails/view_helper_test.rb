require 'test_helper'

describe CSSMRails::ViewHelper, :capybara do
  include CSSMRails::ViewHelper

  before do
    visit page_path
  end

  describe '.scssm' do
    it { page.must_have_selector cssms('event', :title) }
  end

  describe '.css' do
    it { page.wont_have_selector 'p[class^="default_default"]' }
  end
end
