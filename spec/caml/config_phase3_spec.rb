require 'spec_helper'

module Caml
  RSpec.describe Config, 'phase 3 features' do
    it 'parses task needs as a list of strings' do
      config = described_class.load(fixture_path('with_needs.yaml'))
      release = config.tasks.find { |t| t.name == 'release' }

      expect(release.needs).to eq(%w[test lint])
    end
  end
end
