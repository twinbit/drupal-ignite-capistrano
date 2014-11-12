desc "deploy to development environment"
task :stage do
  set :stage_name, "stage"
  set :application, "#APPLICATION_NAME#"
  set :customer, "#NAME_OF_PROJECT_CUSTOMER#"
  set :deploy_to,  "/var/apps/drupal-ignite/#{customer}/#{application}/#{stage_name}"
  set :repository, "#REMOTE_GIT_PATH#"
  set :branch, "develop"
  role :web, "#REMOTE_SERVER_IP[:PORT]#", :primary => true
  role :db, "#REMOTE_SERVER_IP[:PORT]#", :primary => true, :no_release => true
  set :remote_drush, "/usr/bin/drush"
  set :user, "deploy"
  set :use_sudo, false
  set :git_enable_submodules, 1
  ssh_options[:forward_agent] = true
  set :domains, ["#DRUPAL_DOMAIN#"]
  set :default_domain, "#DRUPAL_DOMAIN#"
end
