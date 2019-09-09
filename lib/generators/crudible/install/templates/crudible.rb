Crudible.configure do |config|
  config.new_link_class = 'btn btn-primary btn-sm'
  config.edit_link_class = 'btn btn-primary btn-sm mx-1'
  config.destroy_link_class = 'btn btn-link text-danger btn-sm mx-1'
  config.move_link_class = 'btn btn-secondary btn-sm mx-1'
  config.disabled_link_class = 'disabled'

  config.auth_callback = lambda do |resource, template, action|
    template.policy(resource).public_send("#{action}?")
  end
end
