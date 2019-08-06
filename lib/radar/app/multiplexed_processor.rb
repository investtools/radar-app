class Radar::App::MultiplexedProcessor < Thrift::MultiplexedProcessor
  def process(iprot, oprot)
    begin
      name, type, seqid = iprot.read_message_begin
      super(Thrift::StoredMessageProtocol.new(iprot, [name, type, seqid]), oprot)
    rescue Thrift::Exception => e
      write_error(Thrift::ApplicationException.new(Thrift::ApplicationException::INTERNAL_ERROR, e.message), oprot, name, seqid)
    end
  end

  protected

  def write_error(err, oprot, name, seqid)
    oprot.write_message_begin(name, Thrift::MessageTypes::EXCEPTION, seqid)
    err.write(oprot)
    oprot.write_message_end
    oprot.trans.flush
  end

end
