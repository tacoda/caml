require 'spec_helper'

module Caml
  RSpec.describe 'VERSION' do
    it 'is defined as a non-empty string' do
      expect(Caml::VERSION).to be_a(String).and(satisfy { |v| !v.empty? })
    end
  end
end
