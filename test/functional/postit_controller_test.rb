require File.expand_path('../../test_helper', __FILE__)

class PostitControllerTest < ActionController::TestCase
  
  self.use_instantiated_fixtures = true
  self.fixture_path = File.dirname(__FILE__) + '/../fixtures'
  fixtures :projects
  fixtures :issues
  fixtures :issue_categories
  fixtures :issue_statuses
  fixtures :trackers
  fixtures :users
  fixtures :versions
  
  test "it should generate cards" do
    
    issues_id = ['1', '2', '3', '4']
    
    get :generate, { 'issues_id' => issues_id }
    
    assert_response :success
    
    cards = css_select('.post-it-view')
    
    assert_equal issues_id.length, cards.length
    
  end
  
end