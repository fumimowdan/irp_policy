module Irp
  class SchoolForm < ApplicationRecord
    belongs_to :claim, class_name: "::#{Irp.claim_class}"

    def submit!
      update(submitted_at: Time.zone.now)
    end

    def submitted?
      submitted_at.present?
    end
  end
end
