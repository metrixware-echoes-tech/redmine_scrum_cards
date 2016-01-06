require File.expand_path('../../test_helper', __FILE__)

class PostitControllerTest < ActionController::TestCase
  
  self.use_instantiated_fixtures = true
  self.fixture_path = File.dirname(__FILE__) + '/../fixtures'
  fixtures :users
  fixtures :projects
  fixtures :roles
  fixtures :members
  fixtures :member_roles
  fixtures :issues
  fixtures :issue_categories
  fixtures :issue_statuses
  fixtures :trackers
  fixtures :versions
  
  def extract_cards_elements
    return css_select('.post-it-view')
  end
  
  test "it should generate cards" do
    
    @request.session[:user_id] = 1    # admin user
    
    issues_id = ['1', '2', '3', '4']
    
    get :generate, { 'issues_id' => issues_id }
    assert_response :success
    
    cards = extract_cards_elements  
    assert_equal issues_id.length, cards.length
    
  end
  
  test "anomymous users should not be able to print cards on non-public projects" do
    
    issues_id = ['1']
    assert_not Issue.find(1).project.is_public
    
    get :generate, { 'issues_id' => issues_id }
    assert_response :success
    
    cards = extract_cards_elements
    assert_equal 0, cards.length
    
  end
  
  test "only users who has the right to see an issue can print its card" do
    
    @request.session[:user_id] = 2    # project member
    
    user = User.find(2)
    assert_not_nil user
    
    User.stubs(:current).returns(user)
    
    issue = Issue.find(1)
    issues_id = [issue.id.to_s]
    
    User.current.stubs(:allowed_to?).with(anything(), issue.project).returns(true)
    
    get :generate, { 'issues_id' => issues_id }
    assert_response :success
    
    cards = extract_cards_elements
    assert_equal issues_id.length, cards.length
    
  end
  
end
