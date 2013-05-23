require 'yaml'
require 'erb'
require 'active_support'
require 'active_support/core_ext/hash/deep_merge'

unless defined?(AppConfig)
  AppEnv  = Rails.env unless defined?(AppEnv)
  AppRoot = Rails.root unless defined?(AppRoot)

  raise "Cannot determine App ENV" if AppEnv.nil?
  raise "Cannot determine App ROOT" if AppRoot.nil?

  DefaultConfigFile = AppRoot.join('config', 'app_config_default.yml').freeze
  ConfigFile = AppRoot.join('config', 'app_config.yml').freeze
  raise "Cannot find neither #{DefaultConfigFile} nor #{ConfigFile}! Aborting." unless
    File.exist?(DefaultConfigFile) || File.exist?(ConfigFile)

  AppConfig = {}
  def AppConfig.reload_cfg(cfg)
    File.exist?(cfg) and
      AppConfig.replace AppConfig.deep_merge(YAML.load(ERB.new(File.read(cfg)).result)[AppEnv])
  end
  def AppConfig.reload
    AppConfig.reload_cfg(DefaultConfigFile)
    AppConfig.reload_cfg(ConfigFile)
  end
  AppConfig.reload

  # Some useful shortcuts into AppConfig
  AppConfig.keys.each do |key|
    Kernel.const_set "#{key.split(/[^a-zA-Z]/).map{|x| x.capitalize}.join}Config", AppConfig[key]
  end
end
