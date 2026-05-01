require 'spec_helper'
require 'tmpdir'

module Caml
  RSpec.describe Init do
    describe '.scaffold' do
      it 'writes a starter caml.yaml at the target path' do
        Dir.mktmpdir do |dir|
          target = File.join(dir, 'caml.yaml')

          described_class.scaffold(target)

          expect(File.read(target)).to include('hello:')
        end
      end

      it 'raises Init::Conflict when the file already exists' do
        Dir.mktmpdir do |dir|
          target = File.join(dir, 'caml.yaml')
          File.write(target, 'existing: content')

          expect { described_class.scaffold(target) }
            .to raise_error(Init::Conflict, /#{Regexp.escape(target)}/)
        end
      end
    end
  end
end
