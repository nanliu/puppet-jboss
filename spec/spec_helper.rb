require 'puppet'
require 'mocha'
require 'rspec'
require 'rspec-puppet'

def param_value(subject, type, title, param)
  subject.resource(type, title).send(:parameters)[param.to_sym]
end

RSpec.configure do |c|
  c.mock_with :mocha
  c.module_path  = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures/modules'))
  # Using an empty site.pp file to avoid: https://github.com/rodjek/rspec-puppet/issues/15
  c.manifest_dir = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures/manifests'))
  # Use fixtures for config file mainly to support using our own hiera.yaml settings.
  # Pending: https://github.com/rodjek/rspec-puppet/pull/21
  c.config   = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures/puppet.conf'))
end