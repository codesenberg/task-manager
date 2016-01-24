require 'rails_helper'
require 'shared_contexts'

RSpec.describe "home page", type: :request do
  include_context "api request authentication helper methods"
  include_context "api request global before and after hooks"

  let(:email) { 'user@user.user' }
  let(:password) { '12345678' }
  let(:user) {User.create!(email: email, password: password)}

  it "renders created tasks list" do
    task = Task::Create.(
      name: 'Test task',
      description: 'Test task description',
      user_id: user.id).model
    sign_in(user)
    visit root_path
    expect(page).to have_selector(".panel-heading .pull-left.padding", text: task.name)
    expect(page).to have_selector(".panel-heading .pull-right .padding", text: email)
    expect(page).to have_selector(".panel-body", text: task.description)
  end

  it "displays user email in header" do
    sign_in(user)
    visit root_path
    expect(page).to have_selector(".signout-form .email", text: email)
  end
end