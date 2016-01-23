require 'rails_helper'
require 'shared_contexts'

RSpec.describe "task page", type: :request do
  include_context "api request authentication helper methods"
  include_context "api request global before and after hooks"

  let(:email) { 'user@user.user' }
  let(:password) { '12345678' }
  let(:user) {User.create!(email: email, password: password)}
  let(:task) {
    attachments = [
      {file: FilelessIO.from('image/png', 'digits.png', '123')},
      {file: FilelessIO.from('image/jpeg', 'digits.jpg', '456')}
    ]
    Task::Create.(
      name: 'Hi!', description: 'Hello!', user_id: user.id,
      attachments: attachments).model
  }

  it "should have control buttons" do
    sign_in(user)
    visit task_path(task)

    expect(page).to have_selector('.actions a.btn', text: I18n.t('common.edit'))
    expect(page).to have_selector(".actions input.btn[value=#{I18n.t('common.start')}]")
    expect(page).to have_selector(".actions input.btn[value=#{I18n.t('common.destroy')}]")

    click_button I18n.t('common.start')
    visit task_path(task)
    expect(page).to have_selector('.actions a.btn', text: I18n.t('common.edit'))
    expect(page).to have_selector(".actions input.btn[value=#{I18n.t('common.finish')}]")
    expect(page).to have_selector(".actions input.btn[value=#{I18n.t('common.destroy')}]")

    click_button I18n.t('common.finish')
    visit task_path(task)
    expect(page).to_not have_selector('.row .col-xs-12 a.btn', text: I18n.t('common.edit'))
    expect(page).to_not have_selector(".actions input.btn[value=#{I18n.t('common.destroy')}]")
    expect(page).to_not have_selector(".attachments input.btn[value=#{I18n.t('common.destroy')}]")
    expect(page).to_not have_button(I18n.t('common.attach'))
  end

  it "should allow to start and finish task" do
    sign_in(user)
    visit task_path(task)

    click_button I18n.t('common.start')
    expect(task.reload.state).to eq("started")

    visit task_path(task)
    click_button I18n.t('common.finish')
    expect(task.reload.state).to eq("finished")
  end

  it "should allow to destroy task" do
    sign_in(user)
    visit task_path(task)

    find(".actions input.btn[value=#{I18n.t('common.destroy')}]").click
    expect(Task.find_by(id: task.id)).to be_nil
  end

  it "should allow to destroy attachments" do
    sign_in(user)
    visit task_path(task)

    first(".attachments input.btn[value=#{I18n.t('common.destroy')}]").click
    expect(task.attachments.count).to eq(1)
  end

  it "should allow to add attachments" do
    sign_in(user)
    visit task_path(task)

    attach_file(
      "attachment[file]",
      File.absolute_path('./spec/integration/attachments/empty.png'))
    click_button(I18n.t('common.attach'))
    expect(task.attachments.count).to eq(3)
  end
end