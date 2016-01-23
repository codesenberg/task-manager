class AttachmentsController < ApplicationController
  def download
    run Task::DownloadAttachment, params: params_with_user do |op|
      send_file op.attachment.file.path,
                :disposition => 'attachment'
    end
  end

  def destroy
    run Task::DestroyAttachment, params: params_with_user do |op|
      redirect_to task_url(op.model)
    end
  end

  def add
    attachment_params = params.fetch(:attachment, {})
                            .merge(params.slice(:task_id))
                            .merge(current_user: current_user)
    operation = run Task::AddAttachment, params: attachment_params do |op|
      return redirect_to task_path(op.model)
    end
    flash[:file_upload_errors] = operation.errors.full_messages
    redirect_to :back
  end
end