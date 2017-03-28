require 'rails_helper'
require 'shared_contexts'

RSpec.describe 'create task page', type: :request do
  include_context 'api request authentication helper methods'
  include_context 'api request global before and after hooks'

  let(:email) { 'user@user.user' }
  let(:password) { '12345678' }
  let(:user) { User.create!(email: email, password: password) }

  it 'creates task' do
    sign_in(user)
    visit new_task_path

    default_name = 'Hi!'
    default_description = 'This is my first task!'
    fill_in 'task[name]', with: default_name
    fill_in 'task[description]', with: default_description
    click_button 'Submit'

    created_task = Task.first
    expect(created_task.name).to eq(default_name)
    expect(created_task.description).to eq(default_description)
  end

  it 'creates task with attachments' do
    sign_in(user)
    visit new_task_path

    default_name = 'Hi!'
    default_description = 'This is my first task!'
    fill_in 'task[name]', with: default_name
    fill_in 'task[description]', with: default_description
    attach_file(
      'task[attachments][]',
      [
        File.absolute_path('./spec/integration/attachments/empty.png'),
        File.absolute_path('./spec/integration/attachments/empty-100.png')
      ]
    )
    click_button I18n.t('tasks.submit')

    created_task = Task.first
    expect(created_task.name).to eq(default_name)
    expect(created_task.description).to eq(default_description)
    expect(created_task.attachments.count).to eq(2)
  end
end
