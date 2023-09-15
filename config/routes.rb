Rails.application.routes.draw do
  root 'investments#index'
  get 'calcualte_custom_investment', to: 'investments#calcualte_custom_investment'
  get 'export_csv', to: 'investments#export_csv'
  get 'export_json', to: 'investments#export_json'
end
