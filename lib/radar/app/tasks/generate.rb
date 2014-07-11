require 'thor'
require 'active_support/core_ext/string'

module Radar
  module App
    module Tasks
      class Generate < Thor
        include Thor::Actions

        def self.source_root
          $templates_path
        end

        desc 'analyzer', 'Generate an analyzer'
        argument :name, type: :string, desc: 'Class name'
        def analyzer
          @class_name = name.underscore.camelcase
          template 'analyzers/analyzer.rb.erb', "analyzers/#{filename}"
          template 'spec/analyzers/analyzer_spec.rb.erb', "spec/analyzers/#{spec_filename}"
          append_to_file 'config/app.rb', "\nRadar::App::AnalyzerController << #{@class_name}"
        end

        protected

        def filename
          "#{name.underscore}.rb"
        end
        def spec_filename
          "#{name.underscore}_spec.rb"
        end
      end
    end
  end
end

