module Irp
  module School
    class SubjectStep < Irp::BaseStep
      BASE_PATH = :school_step_path
      ROUTE_KEY = "subject".freeze

      REQUIRED_FIELDS = %i[subject_taught].freeze

      VALID_ANSWERS_OPTIONS = %w[true false].freeze

      def configure_step
        @question      = t("steps.school_subject.question")
        @question_hint = t("steps.school_subject.hint")
        @question_type = :radio
        @valid_answers = [
          Answer.new(value: true, label: t("steps.school_subject.answers.yes.text")),
          Answer.new(value: false, label: t("steps.school_subject.answers.no.text")),
        ]
      end
    end
  end
end
