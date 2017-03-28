# TaskHelper module contains view helpers related to tasks
module TaskHelper
  def status_border_class(task)
    "status-#{task.state}"
  end

  STATE_TO_CSS_CLASS = {
    'added' => 'success',
    'started' => 'danger',
    'finished' => 'default'
  }.freeze

  def status_panel_class(task)
    modificator = STATE_TO_CSS_CLASS[task.state] || 'default'
    "panel-#{modificator}"
  end
end
