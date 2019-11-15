Crudible.configure do |config|
  config.auth_callback = lambda do |resource, template, action|
    template.policy(resource).public_send("#{action}?")
  end
end
