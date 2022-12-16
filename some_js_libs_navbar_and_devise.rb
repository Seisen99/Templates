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

gsub_file('Gemfile', '# gem "sassc-rails"', 'gem "sassc-rails"')

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

inject_into_file 'app/views/layouts/application.html.erb', after: '<body>' do
  <<~HTML
    <%= render "shared/flashes" %>
    <%= render "shared/navbar" %>
  HTML
end

inject_into_file 'app/views/layouts/application.html.erb', before: '</head>' do
  <<~HTML
    <link rel="stylesheet" href="https://unpkg.com/flowbite@1.5.5/dist/flowbite.min.css" />
  HTML
end

inject_into_file 'app/views/layouts/application.html.erb', after: '</html>' do
  <<~HTML
    <script src="https://unpkg.com/flowbite@1.5.5/dist/flowbite.js"></script>
  HTML
end

file 'app/views/shared/_navbar.html.erb', <<~HTML
  <nav class="bg-gray-700 py-2 px-4 flex justify-between items-center">
    <div class="flex items-center">
    <%= link_to "My site", root_path, class: "text-white font-bold text-xl tracking-tight hover:bg-gray-800" %>
    </div>
    <div class="flex items-center">
      <button class="text-white font-bold py-2 px-4 rounded-full focus:outline-none hover:bg-gray-800">Button 1</button>
      <button class="text-white font-bold py-2 px-4 rounded-full focus:outline-none hover:bg-gray-800 ml-4">Button 2</button>
      <button class="text-white font-bold py-2 px-4 rounded-full focus:outline-none hover:bg-gray-800 ml-4">Button 3</button>
      <button class="text-white font-bold py-2 px-4 rounded-full focus:outline-none hover:bg-gray-800 ml-4">Button 4</button>

  <button id="dropdownDefault" data-dropdown-toggle="dropdown" class="text-white font-bold py-2 px-4 rounded-full focus:outline-none hover:bg-gray-800" type="button">Dropdown button</button>
  <!-- Dropdown menu -->
  <div id="dropdown" class="hidden z-10 w-44 bg-gray-700 rounded divide-y divide-gray-100 shadow text-white">
      <ul class="py-1 text-sm text-white dark:text-gray-200" aria-labelledby="dropdownDefault">
        <li>
          <% if user_signed_in? %>
            <%= link_to "Sign out", destroy_user_session_path,  data: {turbo_method: :delete}, class: "block py-2 px-4 hover:bg-gray-800 dark:hover:bg-gray-600 dark:hover:text-white" %>
          <% else %>
            <%= link_to "Sign In", new_user_session_path, class: "block py-2 px-4  hover:bg-gray-800 dark:hover:bg-gray-600 dark:hover:text-white" %>
          <% end %>
        </li>
        <li>
          <a href="#" class="block py-2 px-4  hover:bg-gray-800 dark:hover:bg-gray-600 dark:hover:text-white">Button 1</a>
        </li>
        <li>
          <a href="#" class="block py-2 px-4  hover:bg-gray-800 dark:hover:bg-gray-600 dark:hover:text-white">Button 2</a>
        </li>
        <li>
          <a href="#" class="block py-2 px-4  hover:bg-gray-800 dark:hover:bg-gray-600 dark:hover:text-white">Button 3</a>
        </li>
      </ul>
  </div>
    </div>
  </nav>
HTML

gsub_file(
  'app/views/layouts/application.html.erb',
  '<html>',
  '<html class="bg-gray-800">'
)

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
  remove_file 'app/views/devise/registrations/new.html.erb'
  file 'app/views/devise/registrations/new.html.erb', <<~HTML
      <div class="flex justify-center items-center flex-col">
      <%= form_for(resource, as: resource_name, url: registration_path(resource_name), data: { turbo: :false }, class: "bg-gray-800 py-4 px-6") do |f| %>
        <h2 class="text-white font-bold text-center">Sign up</h2>
        <%= render "devise/shared/error_messages", resource: resource %>

        <div class="field">
          <%= f.label :email, class: "text-white font-bold" %><br />
          <%= f.email_field :email, autofocus: true, autocomplete: "email", class: "bg-gray-700 py-2 px-4 rounded-full focus:outline-none hover:bg-gray-800 text-white font-bold" %>
        </div>

        <div class="field">
          <%= f.label :password, class: "text-white font-bold" %>
          <% if @minimum_password_length %>
          <em>(<%= @minimum_password_length %> characters minimum)</em>
          <% end %><br />
          <%= f.password_field :password, autocomplete: "new-password", class: "bg-gray-700 py-2 px-4 rounded-full focus:outline-none hover:bg-gray-800 text-white font-bold" %>
        </div>

        <div class="field">
          <%= f.label :password_confirmation, class: "text-white font-bold" %><br />
          <%= f.password_field :password_confirmation, autocomplete: "new-password", class: "bg-gray-700 py-2 px-4 rounded-full focus:outline-none hover:bg-gray-800 text-white font-bold" %>
        </div>

        <div class="actions">
          <%= f.submit "Sign up", class: "text-white font-bold py-2 px-4 rounded-full focus:outline-none hover:bg-gray-800" %>
        </div>
      <% end %>

      <%= render "devise/shared/links" %>
    </div>

  HTML
  remove_file 'app/views/devise/sessions/new.html.erb'
  file 'app/views/devise/sessions/new.html.erb', <<~HTML
      <div class="flex justify-center items-center flex-col">
      <%= form_for(resource, as: resource_name, url: session_path(resource_name), data: { turbo: :false }, class: "bg-gray-800 py-4 px-6") do |f| %>
        <h2 class="text-white font-bold text-center">Log in</h2>
        <div class="field">
          <%= f.label :email, class: "text-white font-bold" %><br />
          <%= f.email_field :email, autofocus: true, autocomplete: "email", class: "bg-gray-700 py-2 px-4 rounded-full focus:outline-none hover:bg-gray-800 text-white font-bold" %>
        </div>

        <div class="field">
          <%= f.label :password, class: "text-white font-bold" %><br />
          <%= f.password_field :password, autocomplete: "current-password", class: "bg-gray-700 py-2 px-4 rounded-full focus:outline-none hover:bg-gray-800 text-white font-bold" %>
        </div>

        <% if devise_mapping.rememberable? %>
          <div class="field">
            <%= f.check_box :remember_me, class: "text-white font-bold" %>
            <%= f.label :remember_me, class: "text-white font-bold" %>
          </div>
        <% end %>

        <div class="actions">
          <%= f.submit "Log in", class: "text-white font-bold py-2 px-4 rounded-full focus:outline-none hover:bg-gray-800" %>
        </div>
      <% end %>
      <div class="field">
      </div>
        <%= render "devise/shared/links" %>
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

  remove_file 'app/views/pages/home.html.erb'
  file 'app/views/pages/home.html.erb', <<~HTML
    <div class="flex justify-center w-screen items-center h-screen">
      <h1 id="pages-list" data-controller="pages-list">
        <div>
            <h1 id="pages-list" data-pages-list-target="textElement" class="text-element text-6xl pb-7 pl-4 text-sky-500">Hello! Welcome to your new rails project!</h1>
            <p class="text-gray-300  text-2xl mt-4 p-4">In this app you can use TailwindCSS and Anime.js with React 🥳!</p>
            <p class="text-gray-300  text-2xl p-4">You can also use StimulusJS and Turbo too 🤯.</p>
            <p class="text-gray-300  text-2xl p-4">Have fun!</p>
        </div>
      </h1>
    </div>
  HTML

  run 'npm install animejs --save'
  run 'yarn add aos@next'

  file 'app/javascript/controllers/pages_list_controller.js', <<~JS
        import { Controller } from "@hotwired/stimulus"
        import anime from 'animejs/lib/anime.es.js';
        import AOS from 'aos';
        import 'aos/dist/aos.css'; // You can also use <link> for styles
    // ..
        AOS.init();



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

  inject_into_file 'tailwind.config.js', after: "'./app/assets/stylesheets/**/*.css'," do
    <<~JS
      './app/javascript/components/*.{js,jsx,ts,tsx}',
    JS
  end

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
