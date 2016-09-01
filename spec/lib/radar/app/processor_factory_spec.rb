require 'radar/app/processor_factory'

describe Radar::App::ProcessorFactory do

  let(:parent_processor_class) do
    Class.new do
      attr_reader :write_error_called

      def process_an_error
        begin
          raise 'an error'
        rescue => e
          x = Thrift::ApplicationException.new(Thrift::ApplicationException::INTERNAL_ERROR, 'Internal error')
          write_error(x, nil, nil, nil)
        end
      end

      def process_unknown_method
        x = Thrift::ApplicationException.new(Thrift::ApplicationException::UNKNOWN_METHOD, 'Unknown function')
        write_error(x, nil, nil, nil)
      end

      def write_error(err, oprot, name, seqid)
        @write_error_called = true
      end

    end
  end

  describe '#create_processor' do
    describe 'it creates a processor that' do
      let(:processor) { Radar::App::ProcessorFactory.create_processor(parent_processor_class).new }
      it 'raises the exception on error' do
        expect { processor.process_an_error }.to raise_error 'an error'
      end
      it 'calls #write_error from super' do
        begin
          processor.process_an_error
        rescue => e
          # not testing exception
        end
        expect(processor.write_error_called).to eq true
      end
      context 'when err is not INTERNAL_ERROR' do
        it 'does not raise any exception' do
          expect { processor.process_unknown_method }.not_to raise_error
        end
      end
    end
  end
end
