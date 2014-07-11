$templates_path = File.expand_path('../../../../../templates', File.dirname(__FILE__))
require 'radar/app/runner'
require 'tmpdir'

def in_tmpdir
  olddir = Dir.pwd
  begin
    Dir.mktmpdir do |tmpdir|
      Dir.chdir(tmpdir)
      yield tmpdir
    end
  ensure
    Dir.chdir(olddir)
  end
end

describe Radar::App::Tasks::Generate do
  around do |example|
    in_tmpdir do
      Dir.mkdir 'config'
      File.open('config/app.rb', 'w') { |f| f.write '# ORIGINAL CONTENT' }
      example.run
    end
  end
  describe '#analyzer' do
    it 'appends Analyzer registry to app config' do
      Radar::App::Runner.start(%w{generate analyzer my-test})
      expect(File.read('config/app.rb').lines).to include('Radar::App::AnalyzerController << MyTest')
    end
    context 'when parameter is given in camelcase' do
      it 'creates the analyzer file with underscores' do  
        Radar::App::Runner.start(%w{generate analyzer myTest})
        expect(File).to exist('analyzers/my_test.rb')
      end
      it 'writes the analyzer class with camelcase' do  
        Radar::App::Runner.start(%w{generate analyzer myTest})
        expect(File.read('analyzers/my_test.rb')).to include('class MyTest')
      end
    end

    context 'when parameter is given in hyphen' do
      it 'creates the analyzer file with underscores' do  
        Radar::App::Runner.start(%w{generate analyzer my-test})
        expect(File).to exist('analyzers/my_test.rb')
      end
      it 'writes the analyzer class with camelcase' do  
        Radar::App::Runner.start(%w{generate analyzer my-test})
        expect(File.read('analyzers/my_test.rb')).to include('class MyTest')
      end
    end

    context 'when parameter is given in capitalized' do
      it 'creates the analyzer file decapitalized' do  
        Radar::App::Runner.start(%w{generate analyzer Test})
        expect(File).to exist('analyzers/test.rb')
      end
      it 'writes the analyzer class with camelcase' do  
        Radar::App::Runner.start(%w{generate analyzer test})
        expect(File.read('analyzers/test.rb')).to include('class Test')
      end
    end
  end
end
