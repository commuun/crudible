*******************************************************************************

Next steps:

1. Configure Crudible by editing config/initializers/crudible.rb

2. Include Crudible in the relevant controllers:

    class BlogsController < ApplicationController
      include Crudible::Controller::Base
    end

3. Create your views using the provided helpers.

*******************************************************************************
