require 'spec_helper'
require 'tmpdir'

module Caml
  RSpec.describe Config, '.discover' do
    it 'returns the path when caml.yaml is in the start directory' do
      Dir.mktmpdir do |dir|
        target = File.join(dir, 'caml.yaml')
        File.write(target, "noop:\n  execute: true\n")

        expect(described_class.discover(dir)).to eq(target)
      end
    end

    it 'walks up parent directories until it finds a caml.yaml' do
      Dir.mktmpdir do |root|
        File.write(File.join(root, 'caml.yaml'), "noop:\n  execute: true\n")
        nested = File.join(root, 'a', 'b', 'c')
        FileUtils.mkdir_p(nested)

        expect(described_class.discover(nested)).to eq(File.join(root, 'caml.yaml'))
      end
    end

    it 'returns nil when no caml.yaml exists in any ancestor' do
      Dir.mktmpdir do |dir|
        nested = File.join(dir, 'a', 'b')
        FileUtils.mkdir_p(nested)

        expect(described_class.discover(nested)).to be_nil
      end
    end
  end
end
