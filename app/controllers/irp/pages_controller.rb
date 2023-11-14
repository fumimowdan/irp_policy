module Irp
  class PagesController < ApplicationController
    def index; end
    def closed; end
    def sitemap; end

    def ineligible
      session.delete("irp_form_id")
    end
  end
end
