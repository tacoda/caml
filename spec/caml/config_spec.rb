require 'spec_helper'

module Caml
  RSpec.describe Config do
    describe '.load' do
      it 'loads tasks from a given YAML path' do
        config = described_class.load(fixture_path('simple.yaml'))

        expect(config.tasks.map(&:name)).to contain_exactly('greet', 'build')
      end

      it 'parses each task with its name, desc, and execute' do
        config = described_class.load(fixture_path('simple.yaml'))
        greet = config.tasks.find { |t| t.name == 'greet' }

        expect(greet.desc).to eq('Say hello')
        expect(greet.execute).to eq('echo hello')
      end

      it 'returns an empty task list for an empty YAML file' do
        config = described_class.load(fixture_path('empty.yaml'))

        expect(config.tasks).to be_empty
      end

      it 'raises Config::NotFound with the searched path when the file is missing' do
        missing = '/does/not/exist/caml.yaml'

        expect { described_class.load(missing) }
          .to raise_error(Config::NotFound, /#{Regexp.escape(missing)}/)
      end

      it 'raises Config::Malformed when the YAML cannot be parsed' do
        expect { described_class.load(fixture_path('malformed.yaml')) }
          .to raise_error(Config::Malformed)
      end

      it 'neutralizes Ruby object tags rather than instantiating them' do
        config = described_class.load(fixture_path('with_ruby_object.yaml'))
        attack = config.tasks.find { |task| task.name == 'attack' }

        expect(attack).not_to be_nil
        expect(attack.execute).to be_nil
        expect(attack.desc).to be_nil
      end
    end
  end
end
