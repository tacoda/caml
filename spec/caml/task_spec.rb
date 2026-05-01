require 'spec_helper'

module Caml
  RSpec.describe Task do
    it 'exposes name, desc, and execute from the input data' do
      task = described_class.new(name: 'greet', desc: 'Say hello', execute: 'echo hello')

      expect(task.name).to eq('greet')
      expect(task.desc).to eq('Say hello')
      expect(task.execute).to eq('echo hello')
    end

    it 'defaults args, opts, aliases, and needs to empty when omitted' do
      task = described_class.new(name: 'greet', desc: 'Say hello', execute: 'echo hello')

      expect(task).to have_attributes(args: [], opts: [], aliases: [], needs: [])
    end

    it 'preserves an array execute as written' do
      task = described_class.new(
        name: 'setup',
        desc: 'Multi-step',
        execute: ['echo one', 'echo two']
      )

      expect(task.execute).to eq(['echo one', 'echo two'])
    end
  end
end
