class PostitController < ApplicationController
  unloadable
  
  helper :postit
  
  def generate
    
    Rails.logger.info "generating post-it..."
  
    issues_id = params[:issues_id]
    
    if !issues_id.nil?
                
      issues_id.each{ |id| Rails.logger.info "issue #"+id }     
      
      @issues = Issue.where(id: issues_id)
      
    end
  
    render "postit/generate", :layout => false
  
  end

end