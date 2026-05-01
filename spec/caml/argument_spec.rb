require 'spec_helper'

module Caml
  RSpec.describe Argument do
    it 'exposes name, desc, and type from input data' do
      arg = described_class.new(name: 'target', desc: 'Build target', type: 'string')

      expect(arg).to have_attributes(name: 'target', desc: 'Build target', type: 'string')
    end

    it 'defaults type to "string" when omitted' do
      arg = described_class.new(name: 'target', desc: 'Build target')

      expect(arg.type).to eq('string')
    end
  end
end
