module Irp
  module School
    class EmploymentStep < Irp::BaseStep
      BASE_PATH = :school_step_path
      ROUTE_KEY = "employment-start-date".freeze

      REQUIRED_FIELDS = %i[employment_start_date].freeze

      VALID_ANSWERS_OPTIONS = %w[true false].freeze

      def configure_step
        @question      = t("steps.school_employment_start_date.question")
        @question_hint = t("steps.school_employment_start_date.hint")
        @question_type = :radio
        @valid_answers = [
          Answer.new(value: true, label: t("steps.school_employment_start_date.answers.yes.text")),
          Answer.new(value: false, label: t("steps.school_employment_start_date.answers.no.text")),
        ]
      end
    end
  end
end
