class WelcomeController < ApplicationController
    def index
        render file: 'app/views/welcome/index.html.erb'
    end
end
