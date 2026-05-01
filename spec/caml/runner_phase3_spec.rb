require 'spec_helper'

module Caml
  RSpec.describe Runner, 'phase 3 features' do
    let(:fake_shell) { FakeShell.new }

    def make_task(name, needs: [], execute: "echo #{name}")
      Task.new(name: name, desc: '', execute: execute, needs: needs)
    end

    def runner_for(*tasks)
      described_class.new(tasks: tasks, shell: fake_shell)
    end

    it 'runs deps before the target' do
      a = make_task('a')
      b = make_task('b')
      target = make_task('release', needs: %w[a b])

      runner_for(a, b, target).run('release')

      expect(fake_shell.commands).to eq(['echo a', 'echo b', 'echo release'])
    end

    it 'runs each task once even when multiple paths reach it' do
      build = make_task('build')
      artifact = make_task('artifact', needs: ['build'])
      smoke = make_task('smoke', needs: ['build'])
      target = make_task('deploy', needs: %w[artifact smoke])

      runner_for(build, artifact, smoke, target).run('deploy')

      expect(fake_shell.commands).to eq(['echo build', 'echo artifact', 'echo smoke', 'echo deploy'])
    end

    it 'aborts when a dep fails — subsequent steps do not run' do
      fake_shell.next_results = [true, false]
      a = make_task('a')
      b = make_task('b')
      target = make_task('release', needs: %w[a b])

      result = runner_for(a, b, target).run('release')

      expect(result).to be(false)
      expect(fake_shell.commands).to eq(['echo a', 'echo b'])
    end

    it 'treats a task with no execute as a no-op (for orchestrator-only tasks)' do
      a = make_task('a')
      orchestrator = Task.new(name: 'ci', desc: '', execute: nil, needs: ['a'])

      result = runner_for(a, orchestrator).run('ci')

      expect(result).to be(true)
      expect(fake_shell.commands).to eq(['echo a'])
    end

    it 'applies args and opts only to the target, not to deps' do
      dep = make_task('clean', execute: 'rm -rf out')
      target = Task.new(
        name: 'build',
        desc: '',
        execute: 'make {{target}}',
        needs: ['clean'],
        opts: [Option.new(name: 'target', desc: 'target', type: 'string', default: 'dist')]
      )

      runner_for(dep, target).run('build', opts: { 'target' => 'release' })

      expect(fake_shell.commands).to eq(['rm -rf out', 'make release'])
    end
  end
end
