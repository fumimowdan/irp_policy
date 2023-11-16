module Irp
  class Form < ApplicationRecord
    def academic_year
      # TODO: fix form academic year
      '2023/2024'
    end

    def school
      # TODO: add belongs_to :school to form model
      school_id = "1d9fd4ea-bba3-5421-9338-8fa3305a7e6c"
      Irp.school_class.find_by(id: school_id)
    end

    def teacher_route?
      application_route == "teacher"
    end

    def trainee_route?
      application_route == "salaried_trainee"
    end

    def eligible?
      Form::EligibilityCheck.new(self).passed?
    end

    def complete?
      Form::CompletenessCheck.new(self).passed?
    end

    def validate_eligibility
      return if Form::EligibilityCheck.new(self).passed?

      errors.add(:base, :eligibility, message: Form::EligibilityCheck.new(self).failure_reason)
    end

    def validate_completeness
      return if Form::CompletenessCheck.new(self).passed?

      errors.add(:base, :completeness, message: Form::CompletenessCheck.new(self).failure_reason)
    end

    def deconstruct_keys(_keys)
      attributes.symbolize_keys
    end
  end
end
