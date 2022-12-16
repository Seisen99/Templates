# > Rails new app with tailwind, postgresql and esbuild
rails new myapp --database=postgresql --javascript esbuild --css tailwind -m fancy-template.rb

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
