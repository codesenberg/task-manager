require 'rails_helper'
require 'shared_contexts'

RSpec.describe "edit task page", type: :request do
  include_context "api request authentication helper methods"
  include_context "api request global before and after hooks"

  let(:email) { 'user@user.user' }
  let(:password) { '12345678' }
  let(:user) {User.create!(email: email, password: password)}
  let(:task) {Task::Create.(name: "Hi!", description: "Dummy desc.", user_id: user.id).model}

  it "edits task" do
    sign_in(user)
    visit edit_task_path(task)

    fill_in "task[name]", :with => "New task name!"
    fill_in "task[description]", :with => "New dummy description!"
    click_button "Submit"

    created_task = Task.first
    expect(created_task.name).to eq("New task name!")
    expect(created_task.description).to eq("New dummy description!")
  end
end