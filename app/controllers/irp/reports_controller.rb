module Irp
  class ReportsController < Irp.admin_base_controller_class
    before_action :ensure_service_operator

    def show
      report = Report.call(params[:claim_id])

      send_data(report.data, filename: report.filename)
    end
  end
end
