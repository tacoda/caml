require 'spec_helper'

module Caml
  RSpec.describe Plan do
    def make_task(name, needs: [])
      Task.new(name: name, desc: '', execute: "echo #{name}", needs: needs)
    end

    describe '.resolve' do
      it 'returns just the target when it has no deps' do
        target = make_task('build')

        plan = described_class.resolve('build', [target])

        expect(plan.map(&:name)).to eq(['build'])
      end

      it 'returns deps then the target in declared order' do
        a = make_task('a')
        b = make_task('b')
        target = make_task('release', needs: %w[a b])

        plan = described_class.resolve('release', [a, b, target])

        expect(plan.map(&:name)).to eq(%w[a b release])
      end

      it 'visits each task at most once even when multiple paths reach it' do
        build = make_task('build')
        artifact = make_task('artifact', needs: ['build'])
        smoke = make_task('smoke', needs: ['build'])
        target = make_task('deploy', needs: %w[artifact smoke])

        plan = described_class.resolve('deploy', [build, artifact, smoke, target])

        expect(plan.map(&:name)).to eq(%w[build artifact smoke deploy])
      end

      it 'raises Plan::Cycle when tasks form a cycle' do
        a = make_task('a', needs: ['b'])
        b = make_task('b', needs: ['a'])

        expect { described_class.resolve('a', [a, b]) }
          .to raise_error(Plan::Cycle, /a/)
      end

      it 'raises Plan::UnknownTask for an unknown dep' do
        target = make_task('release', needs: ['ghost'])

        expect { described_class.resolve('release', [target]) }
          .to raise_error(Plan::UnknownTask, /ghost/)
      end

      it 'raises Plan::UnknownTask when the target itself does not exist' do
        expect { described_class.resolve('nope', []) }
          .to raise_error(Plan::UnknownTask, /nope/)
      end
    end
  end
end
