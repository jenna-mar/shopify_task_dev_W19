Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  get '/docs', :to => redirect('docs/index.html')
end
