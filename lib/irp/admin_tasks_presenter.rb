module Irp
  class AdminTasksPresenter
    attr_reader :claim

    def initialize(claim)
      @claim = claim
    end
  end
end
