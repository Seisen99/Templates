# frozen_string_literal: true

run "if uname | grep -q 'Darwin'; then pgrep spring | xargs kill -9; fi"

# Gemfile
########################################
inject_into_file 'Gemfile', before: 'group :development, :test do' do
  <<~RUBY
    gem "devise"
  RUBY
end

inject_into_file 'Gemfile', after: 'gem "debug", platforms: %i[ mri mingw x64_mingw ]' do
  <<-RUBY

  gem "dotenv-rails"
  RUBY
end

# Flashes
########################################
file 'app/views/shared/_flashes.html.erb', <<~HTML
  <% if notice %>
    <div class="fixed inset-0 flex items-center justify-center px-4 py-6 pointer-events-none sm:p-6 sm:items-start sm:justify-start" style="background-color: rgba(0, 0, 0, 0.5);" id="notice">
      <div class="max-w-sm w-full bg-blue-100 border-t-4 border-blue-500 rounded-b text-blue-700 px-4 py-3 shadow-md m-1" role="alert">
        <div class="flex">
          <div class="py-1"><svg class="fill-current h-6 w-6 text-blue-500 mr-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M2.93 17.07A10 10 0 1 1 17.07 2.93 10 10 0 0 1 2.93 17.07zm12.73-1.41A8 8 0 1 0 4.34 4.34a8 8 0 0 0 11.32 11.32zM9 11V9h2v6H9v-4zm0-6h2v2H9V5z"/></svg></div>
          <div>
            <p class="font-bold">Notice</p>
            <p class="text-sm"><%= notice %></p>
          </div>
        </div>
      </div>
    </div>
    <script>
    window.setTimeout(function() {
      var notice = document.getElementById("notice");
      notice.style.display = "none";
      }, 3000);
  </script>
  <% end %>
  <% if alert %>
    <div class="fixed inset-0 flex items-center justify-center px-4 py-6 pointer-events-none sm:p-6 sm:items-start sm:justify-start" style="background-color: rgba(0, 0, 0, 0.5);" id="alert">
      <div class="max-w-sm w-full bg-yellow-100 border-t-4 border-yellow-600 rounded-b text-yellow-700 px-4 py-3 shadow-md m-1" role="alert">
        <div class="flex">
          <div class="py-1"><svg class="fill-current h-6 w-6 text-yellow-500 mr-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M2.93 17.07A10 10 0 1 1 17.07 2.93 10 10 0 0 1 2.93 17.07zm12.73-1.41A8 8 0 1 0 4.34 4.34a8 8 0 0 0 11.32 11.32zM9 5h2v6H9V5zm0 8h2v2H9v-2z"/></svg></div>
          <div>
            <p class="font-bold">Alert</p>
            <p class="text-sm"><%= alert %></p>
          </div>
        </div>
      </div>
    </div>
    <script>
      window.setTimeout(function() {
        var alert = document.getElementById("alert");
        alert.style.display = "none";
        }, 3000);
    </script>
  <% end %>
HTML

# Application.html.erb
########################################
remove_file 'app/views/layouts/application.html.erb'
file 'app/views/layouts/application.html.erb', <<~HTML
  <!DOCTYPE html>
  <html class="bg-gray-900">
    <head>
      <title>TemplateTest</title>
      <meta name="viewport" content="width=device-width,initial-scale=1">
      <%= csrf_meta_tags %>
      <%= csp_meta_tag %>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
      <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
      <%= javascript_include_tag "application", "data-turbo-track": "reload", defer: true %>
    </head>

    <body class="h-screen flex flex-col min-h-screen">
      <header>
        <%= render "shared/navbar" %>
      </header>
      <main class="my-20">
        <%= yield %>
        <%= render "shared/flashes" %>
      </main>
      <footer>
        <%= render "shared/footer" %>
      </footer>
    </body>
  </html>
HTML

# Navbar
########################################
file 'app/views/shared/_navbar.html.erb', <<~HTML
  <nav data-controller="navbar-scroll" data-navbar-scroll-target="navbar" data-action="scroll@window->navbar-scroll#scroll" class="transition-opacity duration-500 ease-in-out fixed w-screen dark:bg-gray-800 py-2 px-4 md:flex md:items-center md:justify-between h-auto rounded-b-lg">
    <div class="flex items-center">
      <%= link_to "Philsdu", root_path, class: "text-gray-100 font-bold text-xl py-2 px-4 rounded-full focus:outline-none hover:bg-gray-900" %>
    </div>
    <div class="flex justify-center items-center md:flex md:items-center md:justify-between h-auto">
      <%= link_to "Home", root_path, class: "text-gray-100 font-bold py-2 px-4 rounded-full focus:outline-none hover:bg-gray-900" %>
      <%= link_to "Hello", root_path, class: "text-gray-100 font-bold py-2 px-4 rounded-full focus:outline-none hover:bg-gray-900" %>
      <%= link_to "Maybe", root_path, class: "text-gray-100 font-bold py-2 px-4 rounded-full focus:outline-none hover:bg-gray-900" %>
      <%= link_to "Pouet", root_path, class: "text-gray-100 font-bold py-2 px-4 rounded-full focus:outline-none hover:bg-gray-900" %>

      <button data-controller="navbar-dropdown" data-action="click->navbar-dropdown#toggle" class=" text-gray-100 font-bold py-2 px-4 rounded-full focus:outline-none hover:bg-gray-900 flex-col" type="button"><i class="fa-solid fa-bars"></i><!-- Dropdown menu -->
        <div data-navbar-dropdown-target="dropdown" data-action="mouseover->navbar-dropdown#openDropdown mouseout->navbar-dropdown#closeDropdown" class="transition ease-in-out delay-1000 right-2 top-16 bg-opacity-70 absolute hidden w-40 bg-gray-700 rounded  divide-gray-100 shadow text-gray-100">
            <ul class="py-1 text-sm text-gray-100 dark:text-gray-100">
              <li>
                <% if user_signed_in? %>
                  <%= link_to "Sign out", destroy_user_session_path,  data: {turbo_method: :delete}, class: "block py-2 px-1 hover:bg-gray-900 dark:hover:bg-gray-600 dark:hover:text-gray-100" %>
                <% else %>
                  <%= link_to "Sign In", new_user_session_path, class: "block py-2 px-1  hover:bg-gray-900 dark:hover:bg-gray-600 dark:hover:text-gray-100" %>
                <% end %>
              </li>
              <li>
                <a href="#" class="block py-2 px-1  hover:bg-gray-900 dark:hover:bg-gray-600 dark:hover:text-gray-100">Account</a>
              </li>
              <li>
                <a href="#" class="block py-2 px-1  hover:bg-gray-900 dark:hover:bg-gray-600 dark:hover:text-gray-100">Terms of use</a>
              </li>
              <li>
                <a href="#" class="block py-2 px-1  hover:bg-gray-900 dark:hover:bg-gray-600 dark:hover:text-gray-100">Something</a>
              </li>
            </ul>
        </div>
      </button>
    </div>
  </nav>
HTML

# Generators
########################################
generators = <<~RUBY
  config.generators do |generate|
    generate.assets false
    generate.helper false
    generate.test_framework :test_unit, fixture: false
  end
RUBY

environment generators

########################################
# After bundle
########################################
after_bundle do
  # Generators: db + pages controller
  ########################################
  rails_command 'db:drop db:create db:migrate'
  generate(:controller, 'pages', 'home', '--skip-routes', '--no-test-framework')

  # Routes
  ########################################
  route 'root to: "pages#home"'

  # Gitignore
  ########################################
  append_file '.gitignore', <<~TXT
    # Ignore .env file containing credentials.
    .env*
    # Ignore Mac and Linux file system files
    *.swp
    .DS_Store
  TXT

  # Devise install + user
  ########################################
  generate('devise:install')
  generate('devise', 'User')

  # Application controller
  ########################################
  run 'rm app/controllers/application_controller.rb'
  file 'app/controllers/application_controller.rb', <<~RUBY
    class ApplicationController < ActionController::Base
      before_action :authenticate_user!

      def after_sign_out_path_for(_resource_or_scope)
        new_user_session_path
      end
    end
  RUBY

  # migrate + devise views
  ########################################
  rails_command 'db:migrate'
  generate('devise:views')
  # better forms
  #######################################

  # Sign up form
  ########################################
  remove_file 'app/views/devise/registrations/new.html.erb'
  file 'app/views/devise/registrations/new.html.erb', <<~HTML
    <div class="flex justify-center w-screen items-center h-screen flex-col">
      <div class="w-full bg-white rounded-lg shadow dark:border md:mt-0 sm:max-w-md xl:p-0 dark:bg-gray-800 dark:border-gray-700">
        <div class="p-6 space-y-4 md:space-y-6 sm:p-8">
          <h1 class="text-xl font-bold leading-tight tracking-tight text-gray-900 md:text-2xl dark:text-white">Sign up</h1>
        <%= form_for(resource, as: resource_name, url: registration_path(resource_name), data: { turbo: :false }, class: "space-y-4 md:space-y-6") do |f| %>
        <%= render "devise/shared/error_messages", resource: resource %>
          <div class="mt-5">
            <label for="email" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your email</label>
            <%= f.email_field :email, autofocus: true, autocomplete: "email", id: "email", class: "bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white" %>
          </div>

          <div class="mt-5">
            <label for="password" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your password</label>
            <%= f.password_field :password, autocomplete: "new-password", id: "password", class: "bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white" %>
            <% if @minimum_password_length %>
            <% end %>
          </div>

          <div class="mt-5">
            <label for="password_confirmation" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Confirm your password</label>
            <%= f.password_field :password_confirmation, autocomplete: "new-password", id: "password_confirmation", class: "bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white" %>

          <div class="actions">
            <%= f.submit "Sign up", class: "mt-7 cursor-pointer w-full py-3 px-6 bg-gray-600 text-base font-medium rounded-lg text-white shadow-md hover:bg-gray-500" %>
          </div>

        <% end %>

        <div class="flex items-center justify-between mt-5">
          <p class="text-sm font-light text-gray-500 dark:text-gray-400">Already have an account? <%= link_to "Sign in", new_session_path(resource_name), class: "font-medium text-gray-300 hover:underline cursor-pointer" %></p>
        </div>
      </div>
    </div>
  HTML

  # Sign in form
  ########################################
  remove_file 'app/views/devise/sessions/new.html.erb'
  file 'app/views/devise/sessions/new.html.erb', <<~HTML
    <div class="flex justify-center w-screen items-center h-screen flex-col">
      <div class="w-full bg-white rounded-lg shadow dark:border md:mt-0 sm:max-w-md xl:p-0 dark:bg-gray-800 dark:border-gray-700">
        <div class="p-6 space-y-4 md:space-y-6 sm:p-8">
          <h1 class="text-xl font-bold leading-tight tracking-tight text-gray-900 md:text-2xl dark:text-white">Sign in to your account</h1>

        <%= form_for(resource, as: resource_name, url: session_path(resource_name), data: { turbo: :false }, class: "space-y-4 md:space-y-6") do |f| %>

          <div class="mt-5">
            <label for="email" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your email</label>
            <%= f.email_field :email, autofocus: true, autocomplete: "email", id: "email", class: "bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white" %>
          </div>

          <div class="mt-5">
            <label for="password" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your password</label>
            <%= f.password_field :password, autocomplete: "current-password", id: "password", class: "bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white" %>
          </div>

          <% if devise_mapping.rememberable? %>

          <div class="flex items-center">
            <%= f.check_box :remember_me, id: "remember-me", class: "mt-1" %>
            <label for="remember-me" class="ml-1 mt-1 text-sm font-medium text-gray-900 dark:text-white">
            <%= f.label :remember_me, class: "ml-2 text-sm font-medium text-gray-900 dark:text-white" %>

          </div>

          <% end %>

          <div class="flex items-center justify-between mt-5">
              <%= f.submit "Sign in", class: "cursor-pointer w-full py-3 px-6 bg-gray-600 text-base font-medium rounded-lg text-white shadow-md hover:bg-gray-500" %>
          </div>

          <div class="flex items-center justify-between mt-5">
            <%= link_to "Forgot your password?", new_password_path(resource_name), class:"cursor-pointer text-indigo-400 hover:text-indigo-200 text-sm font-medium" %>
            <p class="text-sm font-light text-gray-500 dark:text-gray-400">Don't have an account yet? <%= link_to "Sign up", new_registration_path(resource_name), class: "font-medium text-gray-300 hover:underline cursor-pointer" %></p>
          </div>

        <% end %>

        </div>
      </div>
    </div>
  HTML

  # Password reset form
  ########################################
  remove_file 'app/views/devise/passwords/new.html.erb'
  file 'app/views/devise/passwords/new.html.erb', <<~HTML
    <div class="flex justify-center w-screen items-center h-screen flex-col">
      <div class="w-full bg-white rounded-lg shadow dark:border md:mt-0 sm:max-w-md xl:p-0 dark:bg-gray-800 dark:border-gray-700">
        <div class="p-6 space-y-4 md:space-y-6 sm:p-8">
          <h1 class="text-xl font-bold leading-tight tracking-tight text-gray-900 md:text-2xl dark:text-white">Forgot your password?</h1>
          <%= form_for(resource, as: resource_name, url: password_path(resource_name), html: { method: :post }, data: { turbo: :false }, class: "space-y-4 md:space-y-6") do |f| %>
            <%= render "devise/shared/error_messages", resource: resource %>
            <div class="mt-5">
              <label for="email" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your email</label>
              <%= f.email_field :email, autofocus: true, autocomplete: "email", id: "email", class: "bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white" %>
            </div>

            <div class="actions">
              <%= f.submit "Send me reset password instructions", class: "mt-7 cursor-pointer w-full py-3 px-6 bg-gray-600 text-base font-medium rounded-lg text-white shadow-md hover:bg-gray-500" %>
            </div>

          <% end %>

        </div>
      </div>
    </div>
  HTML

  # Errors partial
  ########################################
  remove_file 'app/views/devise/shared/_error_messages.html.erb'
  file 'app/views/devise/shared/_error_messages.html.erb', <<~HTML
    <div class="text-gray-200">
      <% if resource.errors.any? %>
        <div id="error_explanation">
          <h2>
            <%= I18n.t("errors.messages.not_saved",
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)
            %>
          </h2>
          <ul>
            <% resource.errors.full_messages.each do |message| %>
              <li><%= message %></li>
            <% end %>
          </ul>
        </div>
      <% end %>
    </div>
  HTML

  link_to = <<~HTML
    <p>Unhappy? <%= link_to "Cancel my account", registration_path(resource_name), data: { confirm: "Are you sure?" }, method: :delete %></p>
  HTML
  button_to = <<~HTML
    <div class="">
      <div>Unhappy?</div>
      <%= button_to "Cancel my account", registration_path(resource_name), data: { confirm: "Are you sure?" }, method: :delete %>
    </div>
  HTML
  gsub_file('app/views/devise/registrations/edit.html.erb', link_to, button_to)

  # Pages Controller
  ########################################
  run 'rm app/controllers/pages_controller.rb'
  file 'app/controllers/pages_controller.rb', <<~RUBY
    class PagesController < ApplicationController
      skip_before_action :authenticate_user!, only: [ :home ]

      def home
      end
    end
  RUBY

  # Home page view
  ########################################
  remove_file 'app/views/pages/home.html.erb'
  file 'app/views/pages/home.html.erb', <<~HTML
    <div class="flex justify-center w-screen items-center h-screen">
      <div id="pages-list" data-controller="pages-list">
        <div>
            <h1 id="pages-list" data-pages-list-target="textElement" class="text-element text-6xl pb-7 pl-4 text-indigo-400">Hello! Welcome to your new rails project!</h1>
            <p class="text-gray-300  text-2xl mt-4 p-4 text-transparent bg-clip-text bg-gradient-to-r from-indigo-500 via-purple-500 to-pink-500">In this app you can use TailwindCSS and the Anime.js lib for your front-end.</p>
            <p class="text-gray-300  text-2xl p-4 text-transparent bg-clip-text bg-gradient-to-r from-indigo-500 via-purple-500 to-pink-500">You can also use StimulusJS or install React with the "yarn add react react-dom" command.</p>
            <p class="text-4xl p-4 font-extrabold text-transparent bg-clip-text bg-gradient-to-br from-indigo-500 via-purple-500 to-pink-500">The Devise gem for User authentification is already setup. Have fun!</p>
        </div>
      </div>
    </div>
  HTML

  # Footer partial
  ########################################
  file 'app/views/shared/_footer.html.erb', <<~HTML
    <footer class="bottom-0 p-4 rounded-t-lg shadow md:flex md:items-center md:justify-between md:p-6 dark:bg-gray-800">
      <span class="text-sm text-gray-400 sm:text-center dark:text-gray-300">© 2022 <a href="https://seisen99.github.io/profile/" target="/blank" class="hover:underline">Philou™</a> 🚀</span>
        <ul class="flex flex-wrap items-center mt-3 text-sm text-gray-400 dark:text-gray-300 sm:mt-0">
          <li>
              <a href="#" class="mr-4 hover:underline md:mr-6 ">About</a>
          </li>
          <li>
              <a href="#" class="mr-4 hover:underline md:mr-6">Privacy Policy</a>
          </li>
          <li>
              <a href="#" class="mr-4 hover:underline md:mr-6">Licensing</a>
          </li>
          <li>
              <a href="https://seisen99.github.io/landing/" target="/blank" class="hover:underline">Contact</a>
          </li>
        </ul>
    </footer>
  HTML

  #Install Anime.js
  ########################################

  run 'npm install animejs --save'

  # Controller for a cool animation with Anime.js on mouse hover in the home page
  ########################################

  file 'app/javascript/controllers/pages_list_controller.js', <<~JS
    import { Controller } from "@hotwired/stimulus"
    import anime from 'animejs/lib/anime.es.js';

    export default class extends Controller {
      static targets = ['textElement'];

      connect() {
        // Select the text element that you want to animate
        const textElement = this.textElementTarget;

        // Split the text into separate letters
        const letters = textElement.textContent.split('');

        // Empty the text element
        textElement.textContent = '';

        // Add each letter as a separate element
        letters.forEach((letter, index) => {
          // If the current letter is a space, add a space element
          if (letter === ' ') {
            const spaceElement = document.createElement('span');
            spaceElement.innerHTML = '&nbsp;';
            spaceElement.style.display = 'inline-block';
            textElement.appendChild(spaceElement);
          } else {
            const letterElement = document.createElement('span');
            letterElement.textContent = letter;
            letterElement.style.display = 'inline-block';
            textElement.appendChild(letterElement);

            // Set the initial position of each letter to be off the screen at the top



            // Add a mouseover event listener to each letter element
            letterElement.addEventListener('mouseover', () => {
              // Use the Anime.js animate() method to animate the letter element
              anime({
                targets: letterElement,
                scale: [1, 1.5],  // zoom in by 50%
                duration: 500,  // animate over 500 milliseconds

              });
            });

            // Add a mouseout event listener to each letter element
            letterElement.addEventListener('mouseout', () => {
              // Use the Anime.js animate() method to animate the letter element back to its original size
              anime({
                targets: letterElement,
                scale: [1, 1.4, 1, 1.25, 1, 1.15, 1],
                easing: 'easeInOutSine',
                duration: 1000,
              });
            });
          }
        });
      }
    }
  JS

  # Controller for the navbar dropdown
  ########################################
  file 'app/javascript/controllers/navbar_dropdown_controller.js', <<~JS
    import { Controller } from "@hotwired/stimulus"

    // Connects to data-controller="navbar-dropdown"
    export default class extends Controller {
      static targets = [ "dropdown" ]
      connect() {
        console.log("NavbarDropdownController connected")
      }

      toggle() {
        this.dropdownTarget.classList.toggle("hidden")
      }

      openDropdown() {
        this.dropdownTarget.classList.remove("hidden")
      }

      closeDropdown() {
        this.dropdownTarget.classList.add("hidden")
      }
    }
  JS

  # Controller for the hide on scroll navbar
  ########################################
  file 'app/javascript/controllers/navbar_scroll_controller.js', <<~JS
    import { Controller } from "@hotwired/stimulus"

    // Connects to data-controller="navbar-scroll"
    export default class extends Controller {
      static targets = [ "navbar" ]

      connect() {
        console.log("NavbarScrollController connected");
      }

      scroll() {
        this.navbarTarget.classList.add("opacity-0");
        clearTimeout(this.scrollTimeout);
        this.scrollTimeout = setTimeout(() => {
          this.navbarTarget.classList.remove("opacity-0");
        }, 250);
      }
    }
  JS

  # Add controllers too the index.js
  ########################################
  remove_file 'app/javascript/controllers/index.js'
  file 'app/javascript/controllers/index.js', <<~JS
    import { application } from "./application"

    import HelloController from "./hello_controller"
    application.register("hello", HelloController)

    import PagesListController from "./pages_list_controller"
    application.register("pages-list", PagesListController)

    import NavbarDropdownController from "./navbar_dropdown_controller"
    application.register("navbar-dropdown", NavbarDropdownController)

    import NavbarScrollController from "./navbar_scroll_controller"
    application.register("navbar-scroll", NavbarScrollController)
  JS

  # Not sure if this is needed
  ########################################
  remove_file 'app/javascript/application.js'
  file 'app/javascript/application.js', <<~JS
      // Entry point for the build script in your package.json
    import "@hotwired/turbo-rails"
    import "./controllers"
  JS

  # Environments
  ########################################
  environment 'config.action_mailer.default_url_options = { host: "http://localhost:3000" }', env: 'development'
  environment 'config.action_mailer.default_url_options = { host: "http://TODO_PUT_YOUR_DOMAIN_HERE" }',
              env: 'production'

  # Dotenv
  ########################################
  run "touch '.env'"

  # Git
  ########################################
  git :init
  git add: '.'
  git commit: "-m 'Initial commit with devise'"
end
