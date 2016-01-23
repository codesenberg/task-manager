require "rails_helper"

RSpec.describe Task::DestroyAttachment do
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
  let(:finished_task) {
    attachments = [
      {file: FilelessIO.from('image/png', 'digits.png', '123')},
      {file: FilelessIO.from('image/jpeg', 'digits.jpg', '456')}
    ]
    finished = Task::Create.(
      name: 'Hi!', description: 'Hello!', user_id: user.id,
      attachments: attachments).model
    finished.update(state: :finished)
    finished
  }

  it "should destroy attachment" do
    updated_task = Task::DestroyAttachment.(
      id: task.attachments.first.id,
      current_user: user
    ).model
    expect(updated_task.attachments.count).to eq(1)
  end

  it "shouldn't allow to destroy files attached to other people's tasks" do
    expect{
      Task::DestroyAttachment.(
        id: task.attachments.first.id,
        current_user: another_user
      )
    }.to raise_error(Trailblazer::NotAuthorizedError)
  end

  it "shouldn't allow to destroy files attached to finished tasks" do
    expect{
      Task::DestroyAttachment.(
        id: finished_task.attachments.first.id,
        current_user: user
      )
    }.to raise_error(Trailblazer::NotAuthorizedError)
  end
end