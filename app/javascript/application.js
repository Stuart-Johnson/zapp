// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "popper"
import "bootstrap"
import {initializeTooltips, initializeClickableTds} from "./utilities.js"

// Show and hide bootstrap modals when turboframe does it's magic
document.addEventListener('turbo:frame-load', function(event) {
  const modalElement = document.getElementById('turbo_bs_modal')
  const modal = new bootstrap.Modal(modalElement)
  modal.show()
});

document.addEventListener('turbo:before-stream-render', function(event) {
  if (event.target.getAttribute('method') === 'hide') {
    const modalElement = document.getElementById('turbo_bs_modal')
    const modal = bootstrap.Modal.getInstance(modalElement)

    if (event.target.getAttribute('selector')) {
      const selector = (event.target.getAttribute('selector') + " td.clickable_row")
      initializeClickableTds(selector)
    }
    
    if (modal) {
      modal.hide()
    }
    event.preventDefault()
  }

  if (event.target.getAttribute('method') === 'rebind') {
    if (event.target.getAttribute('selector')) {
      const selector = (event.target.getAttribute('selector') + " td.clickable_row")
      initializeClickableTds(selector)
    }
  }
});

document.addEventListener('turbo:load', () => {
  initializeTooltips()
  initializeClickableTds()
});

document.addEventListener("DOMContentLoaded", function(event) {
  initializeTooltips()
});



