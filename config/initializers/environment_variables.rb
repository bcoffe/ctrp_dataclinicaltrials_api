module EnvironmentVariables
  class Application < Rails::Application
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'environment.yml')# "#{File.expand_path('~')}/local/content/ncimatch/conf/ruby/auth0-prodtest.yml"
      if File.exists?(env_file)
        YAML.load_file(env_file)[::Rails.env].each {|k,v| ENV[k] = v }
      end
    end
  end
end