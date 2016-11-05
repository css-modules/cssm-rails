require 'test_helper'

describe CSSMRails::ViewHelper, :capybara do
  before do
    visit page_path
  end

  describe '#cssm' do
    it { page.must_have_selector '.event_title_2R9wz' }
  end
end
