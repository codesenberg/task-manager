require 'rails_helper'

RSpec.describe Task::Update do
  let(:user) { User.create!(email: 'user@user.user', password: '12345678') }
  let(:another_user) do
    User.create!(email: 'another_user@user.user', password: '12345678')
  end
  let(:task) do
    Task::Create.call(name: 'Hi!', description: 'Hello!', user_id: user.id).model
  end
  let(:finished_task) do
    Task.create!(name: 'Hi!', description: 'Done.', user_id: user.id, state: :finished)
  end

  it 'should update task' do
    updated_task = Task::Update.call(
      id: task.id,
      task: { name: 'Hey!', description: 'Hop, la-la-ley!' },
      current_user: user
    ).model
    expect(updated_task.name).to eq('Hey!')
    expect(updated_task.description).to eq('Hop, la-la-ley!')
  end

  it "shouldn't allow to update task with long name" do
    expect do
      Task::Update.call(
        id: task.id,
        task: {
          name: '1' * (Task::MAX_NAME_LENGTH + 1),
          description: 'Hop, la-la-ley!'
        },
        current_user: user
      )
    end.to raise_error(Trailblazer::Operation::InvalidContract)
  end

  it "shouldn't allow to update task with long description" do
    expect do
      Task::Update.call(
        id: task.id,
        task: {
          name: 'Hey!',
          description: '1' * (Task::MAX_DESCRIPTION_LENGTH + 1)
        },
        current_user: user
      )
    end.to raise_error(Trailblazer::Operation::InvalidContract)
  end

  it "shouldn't allow to update other people's tasks" do
    expect do
      Task::Update.call(
        id: task.id,
        task: {
          name: 'Hey!',
          description: 'Hop, la-la-ley!'
        },
        current_user: another_user
      )
    end.to raise_error(Trailblazer::NotAuthorizedError)
  end

  it "shouldn't allow to update finished tasks" do
    expect do
      Task::Update.call(
        id: finished_task.id,
        task: {
          name: 'Hey!',
          description: 'Hop, la-la-ley!'
        },
        current_user: user
      )
    end.to raise_error(Trailblazer::NotAuthorizedError)
  end
end
