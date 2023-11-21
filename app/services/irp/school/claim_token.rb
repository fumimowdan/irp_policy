require 'openssl'

module Irp
  module School
    class ClaimToken
      def self.call(token)
        claim_token = find(token)
        claim_token.claim if claim_token&.valid?
      end

      def self.find(token)
        data = decrypt(token)
        return if data.blank?

        new(**data.symbolize_keys)
      end

      def self.decrypt(token)
        decryptor = OpenSSL::Cipher.new('aes-256-cbc')
        decryptor.decrypt
        decryptor.pkcs5_keyivgen(Irp.claim_token_passphrase, Irp.claim_token_salt)

        encrypted = Base64.decode64(token)
        json = decryptor.update(encrypted)
        json << decryptor.final

        JSON.parse(json)
      rescue StandardError => e
        {}
      end

      def initialize(claim_id:, expires_at: nil)
        @claim = Irp.claim_class.find_by(id: claim_id)
        @expires_at = expires_at
      end

      attr_reader :claim, :expires_at

      def token
        return @token if @token

        encryptor = OpenSSL::Cipher.new('aes-256-cbc')
        encryptor.encrypt
        encryptor.pkcs5_keyivgen(Irp.claim_token_passphrase, Irp.claim_token_salt)

        encrypted = encryptor.update(formatted_claim)
        encrypted << encryptor.final

        @token = Base64.encode64(encrypted)
      end

      def valid?
        claim.present? && \
        !expired? && \
        !school_form_submitted?
      end

      private

      def school_form_submitted?
        SchoolForm.find_by(claim_id: claim.id)&.submitted?
      end

      def expired?
        expires_at < Time.now
      end

      def formatted_claim
        {
          claim_id: claim.id,
          expires_at: 5.day.from_now,
        }.to_json
      end
    end
  end
end
