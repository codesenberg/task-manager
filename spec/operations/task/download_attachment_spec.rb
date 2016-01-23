require 'rails_helper'

RSpec.describe Task::DownloadAttachment do
  let(:user) {User.create!(email: 'user@user.user', password: '12345678')}
  let(:another_user) {
    User.create!(email: 'another_user@user.user', password: '12345678')
  }
  let(:task) {
    attachments = [
      {file: FilelessIO.from('image/png', 'digits.png', '123')},
      {file: FilelessIO.from('image/jpeg', 'digits.jpg', '456')}
    ]
    Task::Create.(
      name: 'Hi!', description: 'Hello!', user_id: user.id,
      attachments: attachments).model
  }

  it "should allow to download attachment" do
    expect{
      Task::DownloadAttachment.(
        id: task.attachments.first.id,
        current_user: user
      )
    }.to_not raise_error
  end

  it "shouldn't allow to download other people's attachments" do
    expect{
      Task::DownloadAttachment.(
        id: task.attachments.first.id,
        current_user: another_user
      )
    }.to raise_error(Trailblazer::NotAuthorizedError)
  end
end