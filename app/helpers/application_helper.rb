module ApplicationHelper
  def render_flash
    return if @_flash_rendered
    
    render partial: "shared/flash"
  end

  def flash_class(flash)
    bootstrap_alert_class = {
      "success" => "alert-success",
      "error" => "alert-danger",
      "notice" => "alert-primary",
      "alert" => "alert-danger",
      "warn" => "alert-warning"
    }
    bootstrap_alert_class[flash]
  end
end
