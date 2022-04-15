#Rails.application.config.hosts << /.*\.(intellart)\.com/

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # origins "*"
    origins "https://localhost:3000"
    resource "*",
      :headers => :any,
      :expose  => ["Authorization"]
      #:methods => [:post]
  end
end
