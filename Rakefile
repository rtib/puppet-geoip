require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'metadata-json-lint/rake_task'
require 'puppet_blacksmith/rake_tasks'
require 'puppet-strings/tasks'

if RUBY_VERSION >= '1.9'
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
end

Blacksmith::RakeTask.new do |t|
  t.tag_pattern = '%s'
end

Rake::Task[:lint].clear
PuppetLint.configuration.send('disable_variable_is_lowercase')
PuppetLint::RakeTask.new :lint do |config|
  config.log_format = '%{path}:%{line}:%{check}:%{KIND}:%{message}'
  config.fail_on_warnings = true
  config.ignore_paths = [
    'test/**/*.pp',
    'vendor/**/*.pp',
    'examples/**/*.pp',
    'spec/**/*.pp',
    'pkg/**/*.pp'
  ]
  config.disable_checks = []
end

desc 'Populate CONTRIBUTORS file'
task :contributors do
  system("git log --format='%aN <%aE>' | sort -u > CONTRIBUTORS")
end

begin
  require 'github_changelog_generator/task'
  GitHubChangelogGenerator::RakeTask.new :changelog do |config|
    version = (Blacksmith::Modulefile.new).version
    config.future_release = "v#{version}"
    config.header = "# Change log\n\nAll notable changes to this project will be documented in this file.\nEach new release typically also includes the latest modulesync defaults.\nThese should not impact the functionality of the module."
    config.exclude_labels = %w{duplicate question invalid wontfix modulesync}
  end
rescue LoadError
end
