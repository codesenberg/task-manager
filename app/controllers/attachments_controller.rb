class AttachmentsController < ApplicationController
  def download
    @attachment = Attachment.find(params[:id])
    fail Trailblazer::NotAuthorizedError unless Task::Policy.new(current_user, @attachment.task).download_attachment?
    send_file @attachment.file.path,
              :disposition => 'attachment'
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    @task = @attachment.task
    fail Trailblazer::NotAuthorizedError unless Task::Policy.new(current_user, @task).destroy_attachment?
    @attachment.destroy and redirect_to task_url(@task)
  end

  def add
    attachment_params = params.fetch(:attachment, {})
                            .merge(params.slice(:task_id))
                            .merge(current_user: current_user)
    operation = run Task::AttachFile, params: attachment_params do |op|
      return redirect_to task_path(op.model)
    end
    flash[:file_upload_errors] = operation.errors.full_messages
    redirect_to :back
  end
end