server '35.163.20.127', user: 'deployer', roles: %w{app web db}

set :branch, 'master'

namespace :deploy do
  after :finished, 'app:restart'
end
