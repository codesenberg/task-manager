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

    fill_in 'task[name]', with: 'Hi!'
    fill_in 'task[description]', with: 'This is my first task!'
    click_button 'Submit'

    created_task = Task.first
    expect(created_task.name).to eq('Hi!')
    expect(created_task.description).to eq('This is my first task!')
  end

  it 'creates task with attachments' do
    sign_in(user)
    visit new_task_path

    fill_in 'task[name]', with: 'Hi!'
    fill_in 'task[description]', with: 'This is my first task!'
    attach_file(
      'task[attachments][]',
      [
        File.absolute_path('./spec/integration/attachments/empty.png'),
        File.absolute_path('./spec/integration/attachments/empty-100.png')
      ]
    )
    click_button I18n.t('tasks.submit')

    created_task = Task.first
    expect(created_task.name).to eq('Hi!')
    expect(created_task.description).to eq('This is my first task!')
    expect(created_task.attachments.count).to eq(2)
  end
end
