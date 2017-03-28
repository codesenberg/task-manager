require 'rails_helper'

RSpec.describe Task::Finish do
  let(:user) { User.create!(email: 'user@user.user', password: '12345678') }
  let(:another_user) do
    User.create!(email: 'another_user@user.user', password: '12345678')
  end
  let(:added_task) do
    Task.create!(
      name: 'Hi!', description: 'Hello!', user_id: user.id,
      state: :added
    )
  end
  let(:started_task) do
    Task.create!(
      name: 'Hi!', description: 'Hello!', user_id: user.id,
      state: :started
    )
  end
  let(:finished_task) do
    Task.create!(
      name: 'Hi!', description: 'Hello!', user_id: user.id,
      state: :finished
    )
  end

  it 'should transition from :started to :finished' do
    new_state = Task::Finish.call(
      id: started_task.id,
      current_user: user
    ).model.state
    expect(new_state).to eq('finished')
  end

  it "shouldn't transition from :added and :finished" do
    expect do
      Task::Finish.call(
        id: added_task.id,
        current_user: user
      )
    end.to raise_error(AASM::InvalidTransition)
    expect do
      Task::Finish.call(
        id: finished_task.id,
        current_user: user
      )
    end.to raise_error(AASM::InvalidTransition)
  end

  it "shouldn't allow to finish other people's tasks" do
    expect do
      Task::Finish.call(
        id: finished_task.id,
        current_user: another_user
      )
    end.to raise_error(Trailblazer::NotAuthorizedError)
  end
end
