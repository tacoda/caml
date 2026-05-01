require 'spec_helper'

module Caml
  RSpec.describe Option do
    it 'exposes name, desc, type, aliases, default, and execute from input data' do
      attrs = { name: 'verbose', desc: 'Be verbose', type: 'boolean',
                aliases: ['v'], default: false, execute: nil }

      expect(described_class.new(**attrs)).to have_attributes(attrs)
    end

    it 'uses sensible defaults when only name and desc are given' do
      opt = described_class.new(name: 'verbose', desc: 'Be verbose')

      expect(opt).to have_attributes(type: 'boolean', aliases: [], default: nil, execute: nil)
    end
  end
end
