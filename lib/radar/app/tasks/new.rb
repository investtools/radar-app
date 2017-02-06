module Radar
  module App
    module Tasks
      class New < Thor::Group
        include Thor::Actions
        namespace :new

        argument :app_name, :type => :string, :desc => "The number to start counting"

        class_option :lang, :type => :string, :aliases => '-l', :default => 'ruby',
                      :desc => 'Choose the programming language. Available options: ruby, java'

        def self.source_root
          $templates_path
        end

        def create_root_directory
          empty_directory app_name.to_s
        end

        def create_basic_files
          copy_file 'Gemfile', "#{app_name}/Gemfile"
          copy_file 'Procfile', "#{app_name}/Procfile"
          copy_file 'DOKKU_SCALE', "#{app_name}/DOKKU_SCALE"
          copy_file 'config/app.rb', "#{app_name}/config/app.rb"
        end

        def create_git_repo
          inside app_name do
            run 'git init'
            run "git remote add production dokku@radar.investtools.com.br:#{app_name}"
          end
        end


        def run_bundle
          inside app_name do
            run 'bundle install'
          end
        end


        # def new_java_project(app_name)
        #   lib_directory = "#{app_name.to_s}/lib"
        #   empty_directory lib_directory
        #   empty_directory "#{app_name.to_s}/src"

        #   download('http://repo2.maven.org/maven2/org/apache/commons/commons-lang3/3.1/commons-lang3-3.1.jar', lib_directory)
        #   download('http://repo2.maven.org/maven2/org/apache/httpcomponents/httpclient/4.2.5/httpclient-4.2.5.jar', lib_directory)
        #   download('http://repo2.maven.org/maven2/org/apache/httpcomponents/httpcore/4.2.4/httpcore-4.2.4.jar', lib_directory)
        #   download('http://repo2.maven.org/maven2/org/apache/thrift/libthrift/0.9.1/libthrift-0.9.1.jar', lib_directory)
        #   download('http://central.maven.org/maven2/log4j/log4j/1.2.16/log4j-1.2.16.jar', lib_directory)
        #   download('http://central.maven.org/maven2/org/slf4j/slf4j-api/1.5.8/slf4j-api-1.5.8.jar', lib_directory)
        #   download('http://central.maven.org/maven2/org/slf4j/slf4j-log4j12/1.5.8/slf4j-log4j12-1.5.8.jar', lib_directory)
        # end
        # def create_project
        #   lang = options[:lang].downcase
        #   case lang
        #     when 'ruby'
        #       new_ruby_project app_name
        #     when 'java'
        #       new_java_project app_name
        #     else
        #       puts 'lang not available'
        #   end
        # end
        # def download(url, dir)
        #   File.join(dir, File.basename(url)).tap do |localpath|
        #     File.open(localpath, 'wb') do |localfile|
        #       begin
        #         Net::HTTP.get_response(URI.parse(url)) do |resp|
        #           puts "error downloading #{url}" if resp.code == '404'
        #           resp.read_body do |segment|
        #             localfile << segment
        #           end
        #         end
        #       rescue EOFError
        #         puts "error downloading #{url}"
        #       end
        #     end
        #   end
        # end
      end
    end
  end
end
