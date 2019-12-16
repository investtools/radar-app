require 'radar/app/processor_factory'

describe Radar::App::ProcessorFactory do
  let(:handler_class) do
    Class.new do
    end
  end

  let(:parent_processor_class) do
    Class.new do
      attr_reader :write_error_called

      def raise_an_error
        raise 'an error'
      end

      def initialize(handler)
      end

      def process_an_error
        begin
          raise 'an error'
        rescue => e
          x = Thrift::ApplicationException.new(Thrift::ApplicationException::INTERNAL_ERROR, 'Internal error')
          write_error(x, nil, nil, nil)
        end
      end

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
      let(:processor) { Radar::App::ProcessorFactory.create_processor(parent_processor_class).new(nil) }
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
  describe 'AppErrorHandler' do
    let(:error_handler) { Radar::App::ProcessorFactory::AppErrorHandler.new }
    let(:target) { double() }
    context 'then target raises a non-Thrift exception' do
      it 'raises an ApplicationError' do
        allow(target).to receive(:raise_an_error).and_raise 'an error'
        error_handler = Radar::App::ProcessorFactory::AppErrorHandler.new(target)
        expect { error_handler.raise_an_error }.to raise_error(Radar::Api::ApplicationError)
      end
      context 'then target raises a Thrift exception' do
        it 'raises the original error' do
          allow(target).to receive(:raise_an_error).and_raise Radar::Api::AuthenticationError.new
          error_handler = Radar::App::ProcessorFactory::AppErrorHandler.new(target)
          expect { error_handler.raise_an_error }.to raise_error(Radar::Api::AuthenticationError)
        end
      end
    end
  end
end
