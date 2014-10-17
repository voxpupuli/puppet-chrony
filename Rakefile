require 'bundler'
Bundler.require(:rake)

require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'

Rake::Task[:lint].clear # https://github.com/rodjek/puppet-lint/issues/331
PuppetLint::RakeTask.new :lint do |config|
  # Pattern of files to check, defaults to `**/*.pp`
  config.log_format = '%{path}:%{linenumber}:%{KIND}: %{message}'
  config.ignore_paths = ["spec/**/*.pp", "vendor/**/*.pp"]
  # TODO: remove this check once the relative config
  # is supported by puppet-lint release
  config.disable_checks = [ 'autoloader_layout' ]
  #config.relative = true
end

# use librarian-puppet to manage fixtures instead of .fixtures.yml
# offers more possibilities like explicit version management, forge downloads,...
task :librarian_spec_prep do
  sh "librarian-puppet install --path=spec/fixtures/modules/"
  pwd = `pwd`.strip
  unless File.directory?("#{pwd}/spec/fixtures/modules/chrony")
    sh "ln -s #{pwd} #{pwd}/spec/fixtures/modules/chrony"
  end
end
task :spec_prep => :librarian_spec_prep


task :default => [:spec, :lint]
