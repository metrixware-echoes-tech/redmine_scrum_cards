class PostitController < ApplicationController
  unloadable
  
  helper :postit
  
  def generate
    
    Rails.logger.info "generating post-it..."
  
    issues_id = params[:issues_id]
    
    if !issues_id.nil?
                
      # retrieve issues
      @issues = Issue.where(id: issues_id)

      # reject issues that the current user is not supposed to see
      @issues = @issues.reject { |issue| !allowed_to_print?(issue) }
      
    end
  
    render "postit/generate", :layout => false
  
  end
  
  private #---------------------------------------------------------------------------------------------------------
  
  def allowed_to_print?(issue)
    
    return true if User.current.admin
    
    return User.current.allowed_to?({ :controller => 'issues', :action => 'show', :id => issue.id }, issue.project)
    
  end

end