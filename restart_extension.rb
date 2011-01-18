# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class RestartExtension < Radiant::Extension
  version "1.0"
  description "Add a restart button for passenger to settings extension"
  url "https://github.com/jfqd/radiant-restart-extension"
  
  define_routes do |map|
    map.with_options(:controller => 'admin/settings') do |settings|
      settings.restart "/admin/settings/restart", :action => 'restart'
    end
  end
  
  def activate
    admin.settings.index.add :bottom, 'restart'
    
    Admin::SettingsController.class_eval do
      def restart
        `touch #{RAILS_ROOT}/tmp/restart.txt`
        redirect_to admin_settings_path
      end
    end
    
  end
end
