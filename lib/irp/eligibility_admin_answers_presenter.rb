module Irp
  class EligibilityAdminAnswersPresenter
    attr_reader :eligibility

    def initialize(eligibility)
      @eligibility = eligibility
    end

    def answers
      [
        [
          "School position",
          eligibility.application_route,
        ],
        [
          "Employed for more than a year",
          eligibility.one_year,
        ],
        [
          "State funded secondary school",
          eligibility.state_funded_secondary_school,
        ],
        [
          "Subject taught",
          eligibility.subject,
        ],
        [
          "Visa",
          eligibility.visa_type,
        ],
        [
          "Employment start date",
          eligibility.start_date,
        ],
        [
          "UK date of entry",
          eligibility.date_of_entry,
        ],
      ]
    end
  end
end
