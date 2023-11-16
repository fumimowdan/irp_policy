module Irp
  class Report

    HEADER_MAPPINGS_KEY = "header_mappings"
    WORKSHEET_NAME_KEY = "worksheet_name"

    def self.call(...)
      report = new(...)
      report.data
      report
    end

    def initialize(claim_id)
      @claim = Irp.claim_class.find(claim_id)
    rescue StandardError
      raise(ArgumentError, "Invalid claim id #{claim_id}")
    end

    attr_reader :claim

    def data
      cell_coords.each { worksheet.add_cell(*_1) }
      workbook.stream.string
    end

    def filename
      "UAS-HO-claim-#{claim.reference}.xlsx"
    end

    private

    def workbook
      @workbook ||= ::RubyXL::Parser.parse_buffer(template.file)
    end

    def template
      @template ||= ReportTemplate.find_by!(report_class: self.class.name)
    end

    def worksheet
      @worksheet ||= workbook[worksheet_name]
    end

    def worksheet_name
      template.config.fetch(WORKSHEET_NAME_KEY)
    end

    def header_mappings
      template.config.fetch(HEADER_MAPPINGS_KEY)
    end

    def headers_with_column_index
      @headers_with_column_index ||= worksheet[0]
        .cells
        .each
        .with_index
        .map { |v, i| [v.value, i] }
    end

    def sheet_col_number(header_mapping)
      _, col_number = headers_with_column_index.detect { |(header, _)| header == header_mapping }

      col_number
    end

    def cell_coords
      dataset.each.with_index.flat_map do |cols, sheet_row_number|
        header_mappings.each.with_index.map do |(header_mapping, _), col_idx|
          [sheet_row_number + 1, sheet_col_number(header_mapping), cols[col_idx].to_s]
        end
      end
    end

    def dataset_fields
      header_mappings.values.map do |cols|
        if cols.size == 1
          cols.first
        else
          Arel.sql("CONCAT(#{cols.join(', \' \', ')})")
        end
      end
    end

    def dataset
      Irp.claim_class
        .where(id: claim.id)
        .pluck(*dataset_fields)
    end
  end
end
