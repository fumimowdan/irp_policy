module Irp
  class AdminTasksPresenter
    attr_reader :claim

    def initialize(claim)
      @claim = claim
    end

    def school_checks
      [
        ["contact school", "Email"]
      ]
    end
  end
end
