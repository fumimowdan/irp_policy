Irp::Engine.routes.draw do
  root to: "pages#index"

  get "/ineligible", to: "pages#ineligible"
  get "/ineligible-salaried-course", to: "pages#ineligible_salaried_course"
  get "/closed", to: "pages#closed"
  get "/privacy", to: "pages#privacy"
  get "/invalid-link", to: "pages#invalid_link"

  constraints(Irp::StepFlow) do
    get "/step/:name", to: "step#new", as: "step"
    post "/step/:name", to: "step#create"
    patch "/step/:name", to: "step#update"
  end

  get "/summary", to: "submission#summary", as: "summary"
  post "/summary", to: "submission#create", as: "new_submission"
  get "/submission", to: "submission#show", as: "submission"

  scope module: :school, path: "school" do
    constraints(Irp::School::StepFlow) do
      get "/step/:name", to: "step#new", as: "school_step"
      post "/step/:name", to: "step#create"
      patch "/step/:name", to: "step#update"
    end

    get "/summary", to: "submission#summary", as: "school_summary"
    post "/summary", to: "submission#create", as: "new_school_submission"
    get "/submission", to: "submission#show", as: "school_submission"
  end

  get "/report/:claim_id", to: "reports#show", as: "report"
end
