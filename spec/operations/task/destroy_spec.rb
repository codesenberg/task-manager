require 'rails_helper'

RSpec.describe Task::Destroy do
  let(:user) { User.create!(email: 'user@user.user', password: '12345678') }
  let(:another_user) do
    User.create!(email: 'another_user@user.user', password: '12345678')
  end
  let(:task) do
    Task::Create.call(
      name: 'Hi!', description: 'Hello!', user_id: user.id
    ).model
  end
  let(:finished_task) do
    finished = Task::Create.call(
      name: 'Hi!', description: 'Hello!', user_id: user.id
    ).model
    finished.update(state: :finished)
    finished
  end

  it 'should destroy task' do
    destroyed_task = Task::Destroy.call(
      id: task.id,
      current_user: user
    ).model

    expect(destroyed_task).to_not be_persisted
  end

  it "shouldn't destroy other people's tasks" do
    expect do
      Task::Destroy.call(
        id: task.id,
        current_user: another_user
      )
    end.to raise_error(Trailblazer::NotAuthorizedError)
  end

  it "shouldn't allow to destroy finished tasks" do
    expect do
      Task::Destroy.call(
        id: finished_task.id,
        current_user: user
      )
    end.to raise_error(Trailblazer::NotAuthorizedError)
  end
end
