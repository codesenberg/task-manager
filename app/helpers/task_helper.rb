module TaskHelper
  def status_border_class(task)
    "status-#{task.state}"
  end

  def status_panel_class(task)
    modificator = case task.state
                    when 'added'
                      'success'
                    when 'started'
                      'danger'
                    when 'finished'
                      'default'
                    else
                      'default'
                  end
    "panel-#{modificator}"
  end
end
