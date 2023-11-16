module Irp
  class ReportsController < ApplicationController
    def show
      report = Report.call(params[:claim_id])

      send_data(report.data, filename: report.filename)
    end
  end
end
