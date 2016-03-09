require_relative '../../lib/code_generator'

describe CodeGenerator do
  describe '.generate' do
    it 'generates a 6-digit code' do
      code = CodeGenerator.generate
      expect(code).to match(/[0-9]{6}/)
    end

    it 'generates a different code every time' do
      code_for_bob   = CodeGenerator.generate
      code_for_alice = CodeGenerator.generate

      expect(code_for_bob).to_not eq(code_for_alice)
    end
  end
end
