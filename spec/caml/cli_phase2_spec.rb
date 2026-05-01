require 'spec_helper'

module Caml
  RSpec.describe CLI, 'phase 2 features' do
    let(:config) { Config.load(fixture_path('feature_rich.yaml')) }
    let(:runner_spy) { RunnerSpy.new }
    let(:cli_class) { Class.new(described_class) }

    before { cli_class.register(config: config, runner: runner_spy) }

    it 'includes positional arg names in the command usage signature' do
      expect(cli_class.commands['greet'].usage).to eq('greet NAME')
    end

    it 'registers Thor options with the declared type, aliases, and default' do
      build_opts = cli_class.commands['build'].options
      verbose = build_opts['verbose']
      target = build_opts['target']

      expect(verbose).to have_attributes(type: :boolean, aliases: ['-v'])
      expect(target).to have_attributes(type: :string, default: 'dist')
    end

    it 'registers task-level aliases via Thor map' do
      expect(cli_class.map).to include('b' => :build, 'compile' => :build)
    end

    it 'passes positional args and option values to Runner#run' do
      cli_class.start(%w[greet world])

      expect(runner_spy.calls.last).to eq(
        name: 'greet',
        args: { 'name' => 'world' },
        opts: {}
      )
    end

    it 'invokes the runner with the canonical task name even when called via an alias' do
      cli_class.start(['b'])

      expect(runner_spy.calls.last[:name]).to eq('build')
    end
  end
end
