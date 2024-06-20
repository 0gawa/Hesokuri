// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery3
//= require jquery_ujs
//= require popper
//= require bootstrap
//= require chartkick
//= require Chart.bundle
import "controllers"
import jquery from "jquery"
window.$ = jquery
import "./jquery.inview.min.js"
import "./toppage.js"

$(function() {
  console.log("Hello Rails7!");
})
