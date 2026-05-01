require 'spec_helper'

module Caml
  RSpec.describe Interpolation do
    describe '.apply' do
      it 'substitutes {{name}} tokens with values from the bindings' do
        result = described_class.apply('echo hello {{name}}', 'name' => 'world')

        expect(result).to eq('echo hello world')
      end

      it 'shell-escapes substituted values to prevent injection' do
        result = described_class.apply('echo {{msg}}', 'msg' => 'a; rm -rf /')

        expect(result).to eq('echo a\\;\\ rm\\ -rf\\ /')
      end

      it 'raises Interpolation::Missing for unbound tokens' do
        expect { described_class.apply('echo {{name}}', {}) }
          .to raise_error(Interpolation::Missing, /name/)
      end

      it 'returns the template unchanged when there are no tokens' do
        result = described_class.apply('echo hello', 'name' => 'unused')

        expect(result).to eq('echo hello')
      end

      it 'substitutes multiple distinct tokens in one template' do
        result = described_class.apply(
          'cp {{src}} {{dst}}',
          'src' => 'a.txt', 'dst' => 'b.txt'
        )

        expect(result).to eq('cp a.txt b.txt')
      end
    end
  end
end
