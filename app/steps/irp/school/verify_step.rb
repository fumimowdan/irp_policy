module Irp
  module School
    class VerifyStep < Irp::BaseStep
      BASE_PATH = :school_step_path
      ROUTE_KEY = "verify".freeze

      REQUIRED_FIELDS = %i[best_person].freeze

      VALID_ANSWERS_OPTIONS = %w[true false].freeze

      attr_accessor :claim_token

      def configure_step
        @question      = t("steps.school_verify.question")
        @question_hint = t("steps.school_verify.hint")
        @question_type = :radio
        @valid_answers = [
          Answer.new(value: true, label: t("steps.school_verify.answers.yes.text")),
          Answer.new(value: false, label: t("steps.school_verify.answers.no.text")),
        ]
      end
    end
  end
end
