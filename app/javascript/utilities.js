import { get, post, put, patch, destroy } from '@rails/request.js'

export const initializeTooltips = () => {
  // Initialize Bootstrap tooltips
  const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-toggle="tooltip"]'))
  tooltipTriggerList.forEach(function (tooltipTriggerEl) {
    new bootstrap.Tooltip(tooltipTriggerEl)
  })
}

export const initializeClickableTds = () => {
  // Add click event listener to all 'clickable-row' td elements
  const clickableTds = document.querySelectorAll('td.clickable_row')
  clickableTds.forEach(td => {
    td.addEventListener('click', function() {
      const url = this.closest('tr').dataset.url

      fetchModalContent(url)
    });
  });
}

async function fetchModalContent(url) {
  const response = await get(url, {responseKind: 'html'})
  if (response.ok) {
    const modalElement = document.getElementById('bs_modal')
    const content = await response.text
    document.getElementById('bs_modal_content').innerHTML = content
    const modal = new bootstrap.Modal(modalElement)
    modal.show()
  }
}
