require 'active_support'

require 'active_support/core_ext/date'
require 'active_support/core_ext/numeric'

ActiveSupport::Dependencies.autoload_paths << './analyzers'


def watchable_args
  files, dirs = [], {}

  ActiveSupport::Dependencies.autoload_paths.each do |path|
    dirs[path.to_s] = [:rb]
  end

  [files, dirs]
end

$class_reloader = ActiveSupport::FileUpdateChecker.new(*watchable_args) do
  ActiveSupport::DescendantsTracker.clear
  ActiveSupport::Dependencies.clear
end

Bundler.require(:default, Radar::App.env)

Thrift.type_checking = true unless Radar::App.env.production?
