namespace :drupal do
  desc "Create files dir for each domain"
  task :setup, :except => { :no_release => true } do
     dirs = [deploy_to, releases_path, shared_path]
     domains.each do |domain|
       dirs += [shared_path + "/#{domain}/files"]
     end
     dirs += %w(system).map { |d| File.join(shared_path, d) }
     run "umask 02 && mkdir -p #{dirs.join(' ')}"
  end

  desc "Symlink files dir from shared path to latest release path"
  task :symlink, :except => { :no_release => true } do
     domains.each do |domain|
        # recreate domain file directory
        run "mkdir -p #{shared_path}/#{domain}/files && chmod 777 #{shared_path}/#{domain}/files";
        run "rm -rf #{latest_release}/sites/#{domain}/files"
        run "ln -s #{shared_path}/#{domain}/files #{latest_release}/sites/#{domain}/files"
     end
  end

  desc "Default directory"
  task :default_dir, :roles => [:web] do
    if !default_domain.empty?
      run "rm -rf #{release_path}/sites/default"
      run "ln -nfs #{release_path}/sites/#{default_domain} #{release_path}/sites/default"
    else
      run "ln -s #{release_path}/sites/default-#{stage_name} #{release_path}/sites/default"
      run "ln -nfs #{release_path}/sites/default-#{stage_name}/settings.#{stage_name}.php #{release_path}/sites/default-#{stage_name}/settings.php"
    end
  end

  desc "Fix htaccess"
  task :htaccess, :roles => [:web] do
    if File.exists?("#{latest_release}/htaccess-#{stage_name}")
      run "mv #{release_path}/htaccess-#{stage_name} #{release_path}/.htaccess"
    else
      run "mv #{release_path}/htaccess #{release_path}/.htaccess"
    end
  end

  desc "Robots"
   task :robots, :roles => [:web] do
    if File.exists?("#{latest_release}/robots.txt-#{stage_name}")
      run "mv #{release_path}/robots.txt-#{stage_name} #{release_path}/robots.txt"
      run "rm -rf #{release_path}/robots.txt-*"
    end
  end

  desc "Clean codebase"
  task :clean, :roles => [:web] do
    run "rm -rf #{release_path}/*.txt"
    run "rm #{release_path}/sites/example.sites.php"
    run "rm #{release_path}/Capfile"
    run "rm -rf #{release_path}/bin"
    run "rm -rf #{release_path}/vendor"
    run "rm -rf #{release_path}/config"
    run "rm -rf #{release_path}/.git"
    run "rm #{release_path}/.gitignore"
    run "rm #{release_path}/behat.yml.dist"
    run "rm #{release_path}/phpunit.xml.dist"
    run "rm #{release_path}/.dcq_ignore"
    run "rm -rf #{release_path}/build.*"
    run "rm -rf #{release_path}/composer.*"
    run "rm -rf #{release_path}/*.make"
    run "rm -rf #{release_path}/*.conf"
  end

  desc "Build the project"
  task :build, :roles => [:web] do
    run "cd #{release_path}; composer update"
    run "cd #{release_path}; bin/phing stage-app"
  end

  desc "Map application to standard path"
  task :app_link, :roles => [:web] do
    run "mkdir -p /var/www/projects/#{customer}/#{application}"
    run "rm -rf /var/www/projects/#{customer}/#{application}/#{stage_name}"
    run "ln -fs #{release_path} /var/www/projects/#{customer}/#{application}/#{stage_name}"
  end

end
