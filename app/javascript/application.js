// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "popper"
import "bootstrap"

// Turbo.session.drive = false


document.addEventListener('turbo:load', () => {
  // Initialize Bootstrap tooltips
  const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-toggle="tooltip"]'))
  tooltipTriggerList.forEach(function (tooltipTriggerEl) {
    new bootstrap.Tooltip(tooltipTriggerEl)
  })

  // Add click event listener to all 'clickable-row' td elements
  const clickableTds = document.querySelectorAll('td.clickable_row')
  clickableTds.forEach(td => {
    td.addEventListener('click', function() {
      const url = this.closest('tr').dataset.url;  // Get the URL from the parent tr
      if (url) {
        Turbo.visit(url, { acceptsStreamResponse: true });
      }
    });
  });
});

document.addEventListener('turbo:frame-load', function(event) {
  const modalElement = document.getElementById('bs_modal');
  const modal = new bootstrap.Modal(modalElement);
  modal.show();
});

document.addEventListener('turbo:before-stream-render', function(event) {
  if (event.target.getAttribute('method') === 'hide') {
    const modalElement = document.getElementById('bs_modal');
    const modal = bootstrap.Modal.getInstance(modalElement);
    if (modal) {
      modal.hide();
    }
    event.preventDefault();
  }
});