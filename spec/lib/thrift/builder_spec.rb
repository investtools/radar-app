$:.unshift File.expand_path('../../../gen-rb', __FILE__)

require 'thrift/builder'
require 'example_types'

describe Thrift::Builder do
  describe '#build' do
    it 'builds a object of type defined by constructor' do
      expect(Thrift::Builder.new(Person).build({})).to be_kind_of(Person)
    end
    it 'sets basic attributes' do
      expect(Thrift::Builder.new(Person).build(name: 'Andre').name).to eq 'Andre'
    end
    it 'sets nested objects' do
      expect(Thrift::Builder.new(Person).build(phone: {}).phone).to be_kind_of(PhoneNumber)
    end
    it 'sets nested objects attributes' do
      expect(Thrift::Builder.new(Person).build(phone: {contry_code: '55'}).phone.contry_code).to eq '55'
    end
    it 'sets nested objects inside arrays' do
      expect(Thrift::Builder.new(Person).build(children: [ { name: 'Helena' } ]).children.first.name).to eq 'Helena'
    end
    it 'sets basic attributes inside arrays' do
      expect(Thrift::Builder.new(Person).build(notes: [ 'test' ]).notes).to eq [ 'test' ]
    end
    it 'sets enum attributes' do
      expect(Thrift::Builder.new(Person).build(gender: :male).gender).to eq Gender::MALE
    end
    it 'sets i32 attributes' do
      expect(Thrift::Builder.new(Person).build(age: 34).age).to eq 34
    end
    it 'sets set attributes' do
      expect(Thrift::Builder.new(Person).build(favorite_numbers: [7, 10]).favorite_numbers).to eq Set.new([7, 10])
    end
  end
end