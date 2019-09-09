# Crudible

Clean & simple CRUD helpers for those who don't need a full-blown admin
interface.

Crudible is intended to be a light weight mixin for your CRUD controllers. It
will add helpers to easily fetch the current resource and provide all the
usual boilerplate CRUD actions.

## Usage

Add to your Gemfile:

    gem 'crudible'

Then update your bundle

    bundle

Finally, run the install generator like so:

    bundle exec rails g crudible:install

## Configuration

Configuration can be changed by modifying `config/initializers/crudible.rb`, for example:

    Crudible.configure do |config|
      # Bootstrap styles for the resource buttons
      config.new_link_class = 'btn btn-primary'
      config.edit_link_class = 'btn btn-primary'
      config.destroy_link_class = 'btn btn-link text-danger'
      config.move_link_class = 'btn btn-secondary'

      config.auth_callback = lambda do |resource, template, action|
        # Authorize actions with Pundit
        template.policy(resource).public_send("#{action}?")
      end
    end

See the `Crudible::Configuration` class for documentation on all options.

## Contributing

Pull requests are welcome but due to my day job I can't guarantee a quick reply.

The usual methods apply:

1. Fork the repo.

2. Run the tests to make sure you have a valid clone.

3. Create a branch for your changes

4. Add a test for your change.

5. Make the test pass (and please check rubocop as well..)

6. Push to your fork and submit a pull request.


## License

Crudible is copyright ©2019 commuun. It is free software, and may be
redistributed under the terms specified in the [LICENSE] file.
