require 'spec_helper'

module Caml
  RSpec.describe Config, 'phase 2 features' do
    let(:config) { described_class.load(fixture_path('feature_rich.yaml')) }

    def task(name)
      config.tasks.find { |t| t.name == name }
    end

    it 'parses task args into Argument objects' do
      arg = task('greet').args.first

      expect(arg).to have_attributes(name: 'name', desc: 'Person to greet', type: 'string')
    end

    it 'parses task opts into Option objects' do
      verbose = task('build').opts.find { |o| o.name == 'verbose' }
      target = task('build').opts.find { |o| o.name == 'target' }

      expect(verbose).to have_attributes(type: 'boolean', aliases: ['v'])
      expect(target).to have_attributes(type: 'string', default: 'dist')
    end

    it 'parses an opt-level execute override' do
      bg = task('start').opts.find { |o| o.name == 'background' }

      expect(bg.execute).to eq('app start --daemon')
    end

    it 'parses task aliases as a list of strings' do
      expect(task('build').aliases).to eq(%w[b compile])
    end
  end
end
