
class IssueWorkflowButtonsHook < Redmine::Hook::ViewListener
  
  render_on(:view_issues_context_menu_end, partial: 'issues/postit_menu')
  
end