module Irp
  class Eligibility < ApplicationRecord
    belongs_to :school, class_name: Irp.school_class.to_s
    has_one :claim, as: :eligibility, inverse_of: :eligibility, class_name: Irp.claim_class.to_s

    def policy
      Irp
    end

    def ineligible?
      false
    end

    def current_school
      school
    end

    def ineligible_reason; end
    def submit!; end
  end
end
