require 'rails_helper'

RSpec.describe Task::DownloadAttachment do
  let(:user) { User.create!(email: 'user@user.user', password: '12345678') }
  let(:another_user) do
    User.create!(email: 'another_user@user.user', password: '12345678')
  end
  let(:task) do
    attachments = [
      { file: FilelessIO.from('image/png', 'digits.png', '123') },
      { file: FilelessIO.from('image/jpeg', 'digits.jpg', '456') }
    ]
    Task::Create.call(
      name: 'Hi!', description: 'Hello!', user_id: user.id,
      attachments: attachments
    ).model
  end

  it 'should allow to download attachment' do
    expect do
      Task::DownloadAttachment.call(
        id: task.attachments.first.id,
        current_user: user
      )
    end.to_not raise_error
  end

  it "shouldn't allow to download other people's attachments" do
    expect do
      Task::DownloadAttachment.call(
        id: task.attachments.first.id,
        current_user: another_user
      )
    end.to raise_error(Trailblazer::NotAuthorizedError)
  end
end
