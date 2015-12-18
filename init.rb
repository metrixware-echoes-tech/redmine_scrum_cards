Redmine::Plugin.register :redmine_scrum_cards do
  name 'Redmine Scrum Cards plugin'
  author 'Echoes Labs'
  description 'Plugin for generating printable scrum cards'
  version '0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  
  settings :default => { 'tester_field_name' => '' }, :partial => 'settings/scrum_cards_settings'
  
end

require 'postit_issue_patch'