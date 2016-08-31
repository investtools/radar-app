require 'radar/app/analyzer'

RSpec.describe Radar::App::Analyzer do
  describe '#dump and #resume' do
    let(:old_analyzer) { analyzer_class.new }
    let(:new_analyzer) { analyzer_class.new }
    let(:analyzer_class) do
      Class.new do
        
        include Radar::App::Analyzer

        def define_vars
          @first_var = '1st'
          @second_var = 2
        end
      end
    end
    it 'dumps and restores all instance variables' do
      old_analyzer.define_vars
      new_analyzer.resume(old_analyzer.dump)
      expect(new_analyzer.instance_variables).to eq [:@first_var, :@second_var]
    end
    it 'dumps and restores instance variable values' do
      old_analyzer.define_vars
      new_analyzer.resume(old_analyzer.dump)
      expect(new_analyzer.instance_variable_get(:@first_var)).to eq '1st'
    end
  end
end
