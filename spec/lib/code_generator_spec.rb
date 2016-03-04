require 'rails_helper'

describe CodeGenerator do
  describe '#generate' do
    it 'provides a code' do
      code = CodeGenerator.generate 
      expect(code).to match(/[0-9]{6}/)
    end
  end
end
