require 'rails_helper'
require 'vcr'
require 'vcr_helper'

describe MessageSender do
  describe '#send_code' do
    it 'sends a code over SMS to a provided number' do
      VCR.use_cassette('send_sms_to_user') do
        success = described_class.send_code('+12025550116', '123456')
        expect(success).to be true
      end
    end
  end
end
