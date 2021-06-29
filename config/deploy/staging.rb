# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

begin
  config = YAML.load_file(File.expand_path('../' + ENV['DEPLOY'] + '.yml', __FILE__))
  server_url = config["server_url"]
  username = config["username"]
  keys = config["keys"]
  branch = config["branch"] || "master"
rescue Exception => e
  # puts e.message
  puts "Sorry, the file config/deploy/" + ENV['DEPLOY'] + '.yml does not exist.'
  exit
end

server server_url, user: username, roles: %w{app db web}
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}

set :default_env, { 'PASSENGER_INSTANCE_REGISTRY_DIR' => '/home/' + config["username"] + '/passenger_tmp' }

set :branch, branch

# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
  set :ssh_options, {
    keys: keys,
#    forward_agent: false,
#    auth_methods: %w(password)
  }

  set :stage, :production

#
# The server-based syntax can be used to override options:
# ------------------------------------
# server "example.com",
#   user: "user_name",
#   roles: %w{web app},
#   ssh_options: {
#     user: "user_name", # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }


namespace(:deploy) do
  after :finishing, :rebuild_sphinx do
    on roles(:app) do
      execute "cd #{current_path} && kill -9 `cat log/production.sphinx.pid` || true"
      execute "export PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH && eval \"$(rbenv init -)\" && cd #{release_path} && bundle exec \"rake ts:rebuild RAILS_ENV=production\""
    end
  end
end