load 'deploy' if respond_to?(:namespace) # cap2 differentiator

load 'config/deploy/includes/misc'
load 'config/deploy/stages'
load 'config/deploy/drupal'
load 'config/deploy/overrides'
load 'config/deploy/drush'

# SCM Stuff configure to taste, just remember the repository
set :scm, :git

# Remote git bin path
set :scm_command, "/usr/bin/git"

# Local git bin path
set :local_scm_command, "git"

set :use_sudo, false
set :git_enable_submodules, true
set :repository,  ""
set :branch, "master"
set :repository_cache, "git_master"
set :deploy_via, :remote_cache
set :scm_verbose, true

# Capistrano settings
set :keep_releases, 12
set :use_sudo, true

# Drush configuration (could be overrided on stages.rb)
set :local_drush, "drush"

# Drush remote path
set :remote_drush, "/home/deploy/bin/drush"






