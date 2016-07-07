# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exists?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

# Note: The cmd option is now required due to the increasing number of ways
#       rspec may be run, below are examples of the most common uses.
#  * bundler: 'bundle exec rspec'
#  * bundler binstubs: 'bin/rspec'
#  * spring: 'bin/rspec' (This will use spring if running and you have
#                          installed the spring binstubs per the docs)
#  * zeus: 'zeus rspec' (requires the server to be started separately)
#  * 'just' rspec: 'rspec'

rspec_options = {
  cmd: "bin/rspec",
  run_all: { parallel: true, parallel_cli: '-n 4' },
}

guard :rspec, rspec_options do
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  # Feel free to open issues for suggestions and improvements

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)

  # Frontend
  watch(%r{^app/.+\.(erb|haml)})
  watch(%r{^app/helpers/.+\.rb})
  watch(%r{^public/.+\.(css|js|html)})
  watch(%r{^config/locales/.+\.yml})


  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch("spec/spec_helper.rb")  { "spec" }

  watch(%r{^app/(.+)\.rb$})                           { |m| "#{rspec.spec_dir}/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.slim|\.haml)$})          { |m| "#{rspec.spec_dir}/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["#{rspec.spec_dir}/routing/#{m[1]}_routing_spec.rb",
  "#{rspec.spec_dir}/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb",
  "#{rspec.spec_dir}/acceptance/#{m[1]}_spec.rb"
  ] }
  watch(%r{^spec/support/(.+)\.rb$})                  { "#{rspec.spec_dir}" }
  watch("config/routes.rb")                           { "#{rspec.spec_dir}/routing" }
  watch("app/controllers/application_controller.rb")  { "#{rspec.spec_dir}/controllers" }

  # Capybara features specs
  watch(%r{^app/views/(.+)/.*\.(erb|slim|haml)$})     { |m| rspec.spec.("features/#{m[1]}") }

  # Turnip features and steps
  watch(%r{^spec/acceptance/(.+)\.feature$})
  watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$}) do |m|
    Dir[File.join("**/#{m[1]}.feature")][0] || "spec/acceptance"
  end
end

# Guard-Rails supports a lot options with default values:
# daemon: false                        # runs the server as a daemon.
# debugger: false                      # enable ruby-debug gem.
# environment: 'development'           # changes server environment.
# force_run: false                     # kills any process that's holding the listen port before attempting to (re)start Rails.
# pid_file: 'tmp/pids/[RAILS_ENV].pid' # specify your pid_file.
# host: 'localhost'                    # server hostname.
# port: 3000                           # server port number.
# root: '/spec/dummy'                  # Rails' root path.
# server: thin                         # webserver engine.
# start_on_start: true                 # will start the server when starting Guard.
# timeout: 30                          # waits untill restarting the Rails server, in seconds.
# zeus_plan: server                    # custom plan in zeus, only works with `zeus: true`.
# zeus: false                          # enables zeus gem.
# CLI: 'rails server'                  # customizes runner command. Omits all options except `pid_file`!

guard 'rails', daemon: true, force_run: true, host: '192.168.213.9' do
  watch('Gemfile.lock')
  watch(%r{^(config|lib)/.*})
end

guard :jasmine do
  watch(%r{spec/javascripts/spec\.(js\.coffee|js|coffee)$}) { 'spec/javascripts' }
  watch(%r{spec/javascripts/.+_spec\.(js\.coffee|js|coffee)$})
  watch(%r{spec/javascripts/fixtures/.+$})
  watch(%r{app/assets/javascripts/(.+?)\.(js\.coffee|js|coffee)(?:\.\w+)*$}) { |m| "spec/javascripts/#{ m[1] }_spec.#{ m[2] }" }
end
