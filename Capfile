require 'capistrano/setup'
require 'capistrano/deploy'
require "capistrano/scm/git"
require 'rvm1/capistrano3'
require 'capistrano/bundler'
require 'capistrano/rails'

install_plugin Capistrano::SCM::Git

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
