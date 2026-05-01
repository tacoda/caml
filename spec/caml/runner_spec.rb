require 'spec_helper'

module Caml
  RSpec.describe Runner do
    let(:fake_shell) { FakeShell.new }
    let(:greet) { Task.new(name: 'greet', desc: 'Say hello', execute: 'echo hello') }
    let(:build) { Task.new(name: 'build', desc: 'Build', execute: 'make build') }
    let(:runner) { described_class.new(tasks: [greet, build], shell: fake_shell) }

    describe '#run' do
      it "passes the task's execute string to the injected shell" do
        runner.run('greet')

        expect(fake_shell.commands).to eq(['echo hello'])
      end

      it 'raises Plan::UnknownTask when no task matches the given name' do
        expect { runner.run('missing') }
          .to raise_error(Plan::UnknownTask, /missing/)
      end

      it 'returns true when the shell reports success' do
        fake_shell.next_result = true

        expect(runner.run('greet')).to be(true)
      end

      it 'returns false when the shell reports failure' do
        fake_shell.next_result = false

        expect(runner.run('build')).to be(false)
      end
    end
  end
end
