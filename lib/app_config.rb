require 'yaml'
require 'erb'
require 'active_support'
require 'active_support/core_ext/hash/deep_merge'

unless defined?(AppConfig)
  AppConfig = {}

  def AppConfig.reload_cfg(cfg, env, root)
    File.exist?(cfg) and
      AppConfig.replace AppConfig.deep_merge(YAML.load(ERB.new(File.read(cfg)).result)[env])
  end

  def AppConfig.reload(env, root)
    env                 = env.to_s
    default_config_file = root.join('config', 'app_config_default.yml').freeze
    config_file         = root.join('config', 'app_config.yml').freeze

    raise "Cannot find neither #{default_config_file} nor #{config_file}! Aborting." unless
      File.exist?(default_config_file) || File.exist?(config_file)

    AppConfig.reload_cfg(default_config_file, env, root)
    AppConfig.reload_cfg(config_file, env, root)

    # Some useful shortcuts into AppConfig
    AppConfig.keys.each do |key|
      begin
        const_name = "#{key.split(/[^a-zA-Z]/).map{|x| x.capitalize}.join}Config"
        Kernel.const_get const_name.intern
      rescue NameError
        Kernel.const_set(const_name, AppConfig[key])
      end
    end
  end

# NOTE: Example usage:
#  AppConfig.reload(Rails.env, Rails.root)
end
