class PostitController < ApplicationController
  unloadable
  
  def generate
    
    Rails.logger.info "generating post-it..."
  
    issues_id = params[:issues_id]
    
    if !issues_id.nil?
                
      issues_id.each{ |id| Rails.logger.info "issue #"+id }
    
      tester_field_name = Setting.plugin_redmine_scrum_cards['tester_field_name']
      @tester_field = IssueCustomField.find_by_name(tester_field_name)
      
      @issues = Issue.where(id: issues_id)
      
    end
  
    render "postit/generate", :layout => false
  
  end
  
end