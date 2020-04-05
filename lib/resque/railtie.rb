module Resque
  class Railtie < Rails::Railtie
    rake_tasks do
      require 'resque/tasks'

      # redefine ths task to load the rails env
      task "resque:setup" => :environment
    end

    initializer "resque.railtie.initializer" do
      if ENV['RESQUE_BASIC_AUTH_PASSWORD']
        require 'resque/server'
        Resque::Server.use(Rack::Auth::Basic) do |username, password|
          username == 'resque' && password == ENV['RESQUE_BASIC_AUTH_PASSWORD']
        end
      end
    end
  end
end

