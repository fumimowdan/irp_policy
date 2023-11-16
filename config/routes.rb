Irp::Engine.routes.draw do
  root to: "pages#index"

  constraints(Irp::StepFlow) do
    get "/step/:name", to: "step#new", as: "step"
    post "/step/:name", to: "step#create"
    patch "/step/:name", to: "step#update"
  end

  get "/summary", to: "submission#summary", as: "summary"
  post "/summary", to: "submission#create", as: "new_submission"
  get "/submission", to: "submission#show", as: "submission"

  get "/ineligible", to: "pages#ineligible"
  get "/ineligible-salaried-course", to: "pages#ineligible_salaried_course"
  get "/closed", to: "pages#closed"
  get "/privacy", to: "pages#privacy"

  get "/report/:claim_id", to: "reports#show", as: "report"

  # constraints(Irp::SchoolStepFlow) do
  #   get "/school/:name", to: "school#new", as: "school"
  #   post "/school/:name", to: "school#create"
  #   patch "/school/:name", to: "school#update"
  # end
end
