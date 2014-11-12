# after trigger
after "deploy", "deploy:cleanup", "drupal:clean", "drupal:htaccess", "drupal:robots", "drush:cc"
after "deploy:setup", "drupal:setup"
# deprecated in the latest versions
after "deploy:symlink", "drupal:symlink"
after "deploy:create_symlink", "drupal:symlink", "drupal:default_dir", "drupal:app_link"
after "deploy:update_code", "drush:db:default", "drupal:build"

namespace :deploy do
  desc "Group writable permission"
  task :finalize_update, :except => { :no_release => true } do
    "chmod -R g+w #{latest_release}" if fetch(:group_writable, true)
  end

  # Each of the following tasks are Rails specific. They're removed.
  task :migrate do
  end

  task :migrations do
  end

  task :cold do
  end

  task :start do
  end

  task :stop do
  end

  task :restart do
  end
end
