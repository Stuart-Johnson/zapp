module ApplicationHelper
  def render_flash
    return if @_flash_rendered
    
    render partial: "shared/flash"
  end
end
