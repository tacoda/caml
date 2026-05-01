require 'spec_helper'

module Caml
  RSpec.describe CLI do
    let(:greet) { Task.new(name: 'greet', desc: 'Say hello', execute: 'echo hello') }
    let(:build) { Task.new(name: 'build', desc: 'Build', execute: 'make build') }
    let(:config) { Config.from_tasks([greet, build]) }
    let(:runner_spy) { RunnerSpy.new }
    let(:cli_class) { Class.new(described_class) }

    before { cli_class.register(config: config, runner: runner_spy) }

    it 'registers one Thor command per task' do
      command_names = cli_class.commands.keys

      expect(command_names).to contain_exactly('greet', 'build')
    end

    it "uses each task's desc on the registered command" do
      expect(cli_class.commands['greet'].description).to eq('Say hello')
      expect(cli_class.commands['build'].description).to eq('Build')
    end

    it 'invokes Runner#run with the task name when the command runs' do
      cli_class.start(['greet'])

      expect(runner_spy.invocations).to eq(['greet'])
    end
  end
end
