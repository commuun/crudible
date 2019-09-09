# Crudible

Clean & simple CRUD helpers for those who don't need a full-blown admin
interface.

Crudible is intended to be a light weight mixin for your CRUD controllers. It
will add helpers to easily fetch the current resource and provide all the
usual boilerplate CRUD actions.


## Installation

Add to your Gemfile (until the gem is released, please use github):

    gem 'crudible', github: 'commuun/crudible'

Then update your bundle

    bundle

Finally, run the install generator like so:

    bundle exec rails g crudible:install


## Configuration

Configuration can be changed by modifying `config/initializers/crudible.rb`,
for example:

    # config/initializers/crudible.rb
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

## Usage

Now you can include Crudible's controller mixins, either directly in your
application controller or any specific controller you want to use:

    # app/controllers/blogs_controller.rb
    class ApplicationController < ActionController::Base
      include Crudible::Controller::Base
    end

This will automatically provide `create`, `update` and `destroy` actions. The
views you will have to make yourself.

You can further customize the controller by overriding various methods, like
`resource_scope` or `find_resource`. Examples:

    # app/controllers/blogs_controller.rb
    class BlogsController < ApplicationController
      include Crudible::Controller::Base

      # Use Pundit to scope the resources
      def resource_scope
        policy_scope(super)
      end

      # Use friendly-id slugs to find resources
      def find_resource
        resource_scope.friendly.find(params[:id])
      end
    end

Please see the `Crudible::Controller::Base` class for full documentation on
overridable methods.

### Strong params

In order to make `create` and `update` actions work you will have to override
the `resource_attributes` method:

    # app/controllers/users_controller.rb
    class UsersController < ApplicationController
      def resource_attributes
        return unless params[:user].present?

        params.require(:user).permit(:email, :last_name)
      end
    end


### View helpers

In your views you can use several helpers to easily access your controller's
resources. For full documentation, check the Crudible::Helper class.

Some examples:

* `resources` gives you the full collection, mainly for the `index` view.
* `resource` the current resource as used in the `show` and `edit` views.
* `human_resource_name` the localized name of the current resource
* `human_resource_names` the pluralized version

An example of an index view built (in HAML) using Crudible

    -# app/views/blogs/index.html.haml
    %p= new_resource_link

    %table
      %thead
        %tr
          %th= attribute_name(:title)
          %th
      %tbody
        - resources.each do |resource|
          %tr
            %td= link_to resource.title, resource_path
            %td= resource_menu(resource)


## Contributing

Pull requests are welcome but due to my day job I can't guarantee a quick reply.

The usual methods apply:

1. Fork the repo.

2. Run the tests to make sure you have a valid clone. (Please use `bundle exec
   appraisal rspec` so all relevant versions of rails are tested, see
   https://github.com/thoughtbot/appraisal)

3. Create a branch for your changes

4. Add a test for your change.

5. Make the test pass (and please check rubocop as well..)

6. Push to your fork and submit a pull request.


## License

Crudible is copyright ©2019 commuun. It is free software, and may be
redistributed under the terms specified in the [LICENSE] file.
