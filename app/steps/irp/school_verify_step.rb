module Irp
  class SchoolVerifyStep < BaseStep
    ROUTE_KEY = "verify".freeze

    REQUIRED_FIELDS = %i[best_person].freeze

    VALID_ANSWERS_OPTIONS = %w[true false].freeze

    def configure_step
      @question      = t("steps.school_details.question")
      @question_hint = t("steps.school_details.hint")
      @question_type = :radio
      @valid_answers = [
        Answer.new(value: true, label: t("steps.school_details.answers.yes.text")),
        Answer.new(value: false, label: t("steps.school_details.answers.no.text")),
      ]
    end
  end
end
