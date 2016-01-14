Redmine::Plugin.register :redmine_scrum_cards do
  
  name 'Redmine Scrum Cards plugin'
  author 'Echoes'
  description 'Plugin for generating printable scrum cards'
  version '1.0.1'
  url 'https://github.com/echoes-tech/redmine_scrum_cards'
  author_url 'https://github.com/echoes-tech'
  
  settings :default => { 
    'tester_field_name' => '', 
    'date_formatter' => "%d/%m/%Y" 
  }, :partial => 'settings/scrum_cards_settings'
  
end

require 'postit_issue_patch'