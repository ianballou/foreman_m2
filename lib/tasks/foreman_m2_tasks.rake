require 'rake/testtask'

# Tasks
namespace :foreman_m2 do
  namespace :example do
    desc 'Example Task'
    task task: :environment do
      # Task goes here
    end
  end
end

# Tests
namespace :test do
  desc 'Test ForemanM2'
  Rake::TestTask.new(:foreman_m2) do |t|
    test_dir = File.join(File.dirname(__FILE__), '../..', 'test')
    t.libs << ['test', test_dir]
    t.pattern = "#{test_dir}/**/*_test.rb"
    t.verbose = true
    t.warning = false
  end
end

namespace :foreman_m2 do
  task :rubocop do
    begin
      require 'rubocop/rake_task'
      RuboCop::RakeTask.new(:rubocop_foreman_m2) do |task|
        task.patterns = ["#{ForemanM2::Engine.root}/app/**/*.rb",
                         "#{ForemanM2::Engine.root}/lib/**/*.rb",
                         "#{ForemanM2::Engine.root}/test/**/*.rb"]
      end
    rescue StandardError
      puts 'Rubocop not loaded.'
    end

    Rake::Task['rubocop_foreman_m2'].invoke
  end
end

Rake::Task[:test].enhance ['test:foreman_m2']

load 'tasks/jenkins.rake'
if Rake::Task.task_defined?(:'jenkins:unit')
  Rake::Task['jenkins:unit'].enhance ['test:foreman_m2', 'foreman_m2:rubocop']
end
