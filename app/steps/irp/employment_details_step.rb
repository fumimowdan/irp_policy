module Irp
  class EmploymentDetailsStep < BaseStep
    ROUTE_KEY = "employment-details".freeze

    # REQUIRED_FIELDS = %i[
    #   school_name
    #   school_headteacher_name
    #   school_address_line_1
    #   school_city
    #   school_postcode
    #   ].freeze

    # OPTIONAL_FIELDS = %i[school_address_line_2].freeze

    REQUIRED_FIELDS = %i[school_id].freeze

    # validates :school_postcode, postcode: true

    VALID_ANSWERS_OPTIONS = Irp.school_class.pluck(:id)

    def configure_step
      @question = t("steps.employment_details.question")
      @question_type = :select
      @valid_answers = Irp.school_class.order(name: :asc).pluck(:id, :name).map { Answer.new(value: _1.first, label: _1.last ) }
    end
  end
end
