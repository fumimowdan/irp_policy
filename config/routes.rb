Irp::Engine.routes.draw do
  root to: "pages#index"

  # constraints(StepFlow) do
  #   get "/step/:name", to: "step#new", as: "step"
  #   post "/step/:name", to: "step#create"
  #   patch "/step/:name", to: "step#update"
  # end

  # get "/summary", to: "submission#summary", as: "summary"
  # post "/summary", to: "submission#create", as: "new_submission"
  # get "/submission", to: "submission#show", as: "submission"

  get "/ineligible", to: "pages#ineligible"
  get "/ineligible-salaried-course", to: "pages#ineligible_salaried_course"
  get "/closed", to: "pages#closed"
  get "/privacy", to: "pages#privacy"
end
