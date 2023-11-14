require "govuk/components"

module Irp
  class Engine < ::Rails::Engine
    isolate_namespace Irp

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
