require 'spec_helper'

module Caml
  RSpec.describe Runner, 'phase 2 features' do
    let(:fake_shell) { FakeShell.new }

    def runner_for(*tasks)
      described_class.new(tasks: tasks, shell: fake_shell)
    end

    it 'interpolates arg values into the execute string' do
      task = Task.new(
        name: 'greet',
        desc: 'Say hello',
        execute: 'echo hello {{name}}',
        args: [Argument.new(name: 'name', desc: 'Person')]
      )

      runner_for(task).run('greet', args: { 'name' => 'world' })

      expect(fake_shell.commands).to eq(['echo hello world'])
    end

    it 'interpolates opt values into the execute string' do
      task = Task.new(
        name: 'build',
        desc: 'Build',
        execute: 'make build {{target}}',
        opts: [Option.new(name: 'target', desc: 'Target', type: 'string', default: 'dist')]
      )

      runner_for(task).run('build', opts: { 'target' => 'release' })

      expect(fake_shell.commands).to eq(['make build release'])
    end

    it "uses an opt's own execute when that opt is truthy" do
      task = Task.new(
        name: 'start',
        desc: 'Start',
        execute: 'app start',
        opts: [Option.new(name: 'background', desc: 'Daemon', type: 'boolean', execute: 'app start --daemon')]
      )

      runner_for(task).run('start', opts: { 'background' => true })

      expect(fake_shell.commands).to eq(['app start --daemon'])
    end

    it "ignores an opt's own execute when that opt is falsy" do
      task = Task.new(
        name: 'start',
        desc: 'Start',
        execute: 'app start',
        opts: [Option.new(name: 'background', desc: 'Daemon', type: 'boolean', execute: 'app start --daemon')]
      )

      runner_for(task).run('start', opts: { 'background' => false })

      expect(fake_shell.commands).to eq(['app start'])
    end

    it 'joins an array execute with && so failures abort the run' do
      task = Task.new(
        name: 'setup',
        desc: 'Setup',
        execute: ['echo step-one', 'echo step-two']
      )

      runner_for(task).run('setup')

      expect(fake_shell.commands).to eq(['echo step-one && echo step-two'])
    end
  end
end
