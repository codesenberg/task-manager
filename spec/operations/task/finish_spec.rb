require 'rails_helper'

RSpec.describe Task::Finish do
  let(:user) {User.create!(email: 'user@user.user', password: '12345678')}
  let(:another_user) {
    User.create!(email: 'another_user@user.user', password: '12345678')
  }
  let(:added_task) {
    Task.create!(
      name: 'Hi!', description: 'Hello!', user_id: user.id,
      state: :added)
  }
  let(:started_task) {
    Task.create!(
      name: 'Hi!', description: 'Hello!', user_id: user.id,
      state: :started)
  }
  let(:finished_task) {
    Task.create!(
      name: 'Hi!', description: 'Hello!', user_id: user.id,
      state: :finished)
  }

  it "should transition from :started to :finished" do
    new_state = Task::Finish.(
      id: started_task.id,
      current_user: user
    ).model.state
    expect(new_state).to eq("finished")
  end

  it "shouldn't transition from :added and :finished" do
    expect{
      Task::Finish.(
        id: added_task.id,
        current_user: user
      )
    }.to raise_error(AASM::InvalidTransition)
    expect{
      Task::Finish.(
        id: finished_task.id,
        current_user: user
      )
    }.to raise_error(AASM::InvalidTransition)
  end

  it "shouldn't allow to finish other people's tasks" do
    expect{
      Task::Finish.(
        id: finished_task.id,
        current_user: another_user
      )
    }.to raise_error(Trailblazer::NotAuthorizedError)
  end

end