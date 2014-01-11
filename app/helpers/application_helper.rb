module ApplicationHelper
  def flash_class(level)
    case level
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-error"
    when :alert then "alert alert-error"
    end
  end

  def sortable(colunm , title = nil)
    title ||= colunm.titleize
    direction = params[:direction] == "desc" ? "asc" : "desc" #colunm == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
    link_to title, sort: colunm, direction: direction
  end
end
