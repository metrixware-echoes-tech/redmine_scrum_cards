require File.expand_path('../../test_helper', __FILE__)

class PostitHelperTest < ActiveSupport::TestCase
  
  self.use_instantiated_fixtures = true
  self.fixture_path = File.dirname(__FILE__) + '/../fixtures'
  fixtures :versions
  fixtures :users
  
  @@tester_field_name = 'tester_field_name'
  @@date_formatter = 'date_formatter'
  
  setup do
    @settings = Setting.plugin_redmine_scrum_cards
    @helper = Object.new
    @helper.extend(PostitHelper)
  end

  test "it should return the version associated to the issue" do
    
    issue = Issue.new
    issue.fixed_version_id = 1
    
    version = Version.find(1)
    
    assert_not version.nil?
    assert_equal version, @helper.get_issue_version(issue)
    
  end
  
  test "it should not raise an exception when retrieving the version associated to an issue when it there is none" do
    
    issue = Issue.new
    
    assert_equal nil, @helper.get_issue_version(issue)
    
  end
  
  test "it should retrieve the due date of an issue when it is defined" do 
    
    issue = Issue.new
    issue.due_date = "2005-01-01".to_date
    
    assert_equal issue.due_date, @helper.get_issue_due_date(issue)
    
  end
  
  test "it should use the effective date of the version if the issue due date is not defined" do 
    
    issue = Issue.new
    issue.fixed_version_id = 1
    
    version = Version.find(1)
    
    assert_not version.nil?
    assert_not version.effective_date.nil?
    assert_equal version.effective_date, @helper.get_issue_due_date(issue)
    
  end
  
  test "it shoud not raise an exception when retrieving an undefined due date of an issue" do
    
    issue = Issue.new
    issue.fixed_version_id = 2
    
    version = Version.find(2)
    
    assert_not version.nil?
    assert version.effective_date.nil?
    
    assert_equal nil, @helper.get_issue_due_date(issue)
    
  end
  
  test "it should retrieve the issue tester" do
    
    field_id = 35
    field_name = "tester"
    
    @settings[@@tester_field_name] = field_name
    
    field = mock()
    field.expects(:nil?).returns(false)
    field.expects(:id).returns(field_id)
    
    tester_id = 1
    tester = User.find(tester_id)
    
    issue = mock()
    issue.expects(:custom_value_for).with(field_id).returns(tester_id)
    
    IssueCustomField.stubs(:find_by_name).with(field_name).returns(field)
    
    assert_not tester.nil?
    assert_equal tester, @helper.get_issue_tester(issue)
    
  end
  
  test "it should not raise an exception when retrieving the tester of an issue when no custom field has been defined" do
    
    field_name = nil
    issue = mock()
    
    assert_equal nil, @helper.get_issue_tester(issue)
    
  end
  
  test "it should not raise an exception when retrieving the tester of an issue when it has not been defined" do
    
    field_id = 35
    field_name = "tester"
    
    @settings[@@tester_field_name] = field_name
    
    field = mock()
    field.expects(:nil?).returns(false)
    field.expects(:id).returns(field_id)
    
    issue = mock()
    issue.expects(:custom_value_for).with(field_id).returns(nil)
    
    IssueCustomField.stubs(:find_by_name).with(field_name).returns(field)
    
    assert_equal nil, @helper.get_issue_tester(issue)
    
  end
  
  test "it should retrieve the date format from the settings" do
    
    date_format = "test"   
    @settings[@@date_formatter] = date_format
    
    assert_equal date_format, @helper.get_date_format()
    
  end
  
  test "it should retrieve the default date format when the date format has not been defined" do
    
    @settings[@@date_formatter] = nil
    
    date_format = @helper.get_date_format()
    
    assert_not date_format.nil?
    assert_not date_format.empty?
    
  end
  
  test "it should retrieve the default date format when the defined date format is an empty string" do
    
    @settings[@@date_formatter] = ''
    
    date_format = @helper.get_date_format()
    
    assert_not date_format.nil?
    assert_not date_format.empty?
    
  end
  
end
