require 'rails_helper'

RSpec.describe Task::Destroy do
  let(:user) {User.create!(email: 'user@user.user', password: '12345678')}
  let(:another_user) {
    User.create!(email: 'another_user@user.user', password: '12345678')
  }
  let(:task) {
    Task::Create.(
      name: 'Hi!', description: 'Hello!', user_id: user.id).model
  }
  let(:finished_task) {
    finished = Task::Create.(
      name: 'Hi!', description: 'Hello!', user_id: user.id).model
    finished.update(state: :finished)
    finished
  }

  it "should destroy task" do
    destroyed_task = Task::Destroy.(
      id: task.id,
      current_user: user
    ).model

    expect(destroyed_task).to_not be_persisted
  end

  it "shouldn't destroy other people's tasks" do
    expect{
      Task::Destroy.(
        id: task.id,
        current_user: another_user
      )
    }.to raise_error(Trailblazer::NotAuthorizedError)
  end

  it "shouldn't allow to destroy finished tasks" do
    expect{
      Task::Destroy.(
        id: finished_task.id,
        current_user: user
      )
    }.to raise_error(Trailblazer::NotAuthorizedError)
  end
end