module Irp
  class Form < ApplicationRecord
#    belongs_to :school, class_name: "::#{Irp.school_class}"

    def school
      Irp.school_class.find_by(id: school_id)
    end

    def academic_year
      Irp.config_class.for(Irp).current_academic_year
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
