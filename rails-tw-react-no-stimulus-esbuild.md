# > Rails new app with tailwind, postgresql and esbuild
rails new myapp --database=postgresql --javascript esbuild --css tailwind

# > Add react
yarn add react
yarn add react-dom

# > Add the following in the tailwind.config.js file :

module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/components/*.{js,jsx,ts,tsx}',  # <--- add this line
    './app/javascript/**/*.js'
  ]
}


# > In each react component:

import React from 'react';
import ReactDOM from 'react-dom/client';
## Import other js libraries, for example :
import anime from 'animejs/lib/anime.es.js';



## Don't forget to add the following in the application.js file :
import "./components/your_component_name"

you can delete the import of the stimulus controller  (import "controllers" from "@hotwired/stimulus" )
and the import of the hotwire (import { Turbo, cable } from "@hotwired/turbo-rails" )


## Template 1 with Tailwind, Postgresql, Esbuild, React, Animejs and Devise (still with Stimulus and turbo-rails) :
rails new myapp2test --database=postgresql --javascript esbuild --css tailwind -m https://raw.githubusercontent.com/Seisen99/Templates/main/fancy_template.rb


# TEMPLATE 2 : Rails new app with tailwind, postgresql and esbuild, anime.js and aos.js.
## With devise gem set up, home page and about page, and a navbar with a dropdown menu. (AOS works only with the rails s + yarn build watch, dunno why it doesn't work with ./bin/dev command on local...)
> rails new appname -d postgresql -j esbuild --css tailwind -m https://raw.githubusercontent.com/Seisen99/Templates/main/some_js_libs_navbar_and_devise.rb
