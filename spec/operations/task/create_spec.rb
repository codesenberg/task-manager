require 'rails_helper'

RSpec.describe Task::Create do
  let(:user) { User.create!(email: 'user@user.user', password: '12345678') }
  it 'should create task' do
    task = Task::Create.call(name: 'Hi!', description: 'Hello!', user_id: user.id).model
    expect(task.name).to eq('Hi!')
    expect(task.description).to eq('Hello!')
  end

  it 'should raise on bad input' do
    expect do
      Task::Create.call(name: '', description: '', user_id: nil)
    end.to raise_error(Trailblazer::Operation::InvalidContract)
  end

  it "shouldn't create orphan tasks" do
    expect do
      Task::Create.call(name: 'Hi!', description: 'Hello!', user_id: -1)
    end.to raise_error(ActiveRecord::InvalidForeignKey)
  end

  it "shouldn't create task with long name" do
    expect do
      Task::Create.call(
        name: '1' * (Task::MAX_NAME_LENGTH + 1),
        description: 'Hello!', user_id: user.id
      )
    end.to raise_error(Trailblazer::Operation::InvalidContract)
  end

  it "shouldn't create task with long description" do
    expect do
      Task::Create.call(
        name: '1' * (Task::MAX_DESCRIPTION_LENGTH + 1),
        description: 'Hello!', user_id: user.id
      )
    end.to raise_error(Trailblazer::Operation::InvalidContract)
  end

  it 'should create task with single attachment' do
    attachments = [{ file: FilelessIO.from('image/png', 'digits.png', '123') }]
    task = Task::Create.call(
      name: 'Hi!', description: 'Hello!', user_id: user.id,
      attachments: attachments
    ).model
    expect(task.attachments.first.file.read).to eq '123'
  end

  it 'should create task with multiple attachments' do
    attachments = [
      { file: FilelessIO.from('image/png', 'digits.png', '123') },
      { file: FilelessIO.from('image/jpeg', 'digits.jpg', '456') }
    ]
    task = Task::Create.call(
      name: 'Hi!', description: 'Hello!', user_id: user.id,
      attachments: attachments
    ).model

    expect(task.attachments.map(&:file).map(&:read)).to eq %w(123 456)
  end

  it "shouldn't create task with large attachments" do
    attachments = [
      { file: FilelessIO.from('image/png',
                              'digits.png',
                              '1' * (Attachment::MAX_FILE_SIZE + 1)) }
    ]
    expect do
      Task::Create.call(
        name: 'Hi!', description: 'Hello!', user_id: user.id,
        attachments: attachments
      )
    end.to raise_error(Trailblazer::Operation::InvalidContract)
  end

  it "shouldn't create task with unallowed attachment type" do
    attachments = [
      { file: FilelessIO.from('image/gif', 'digits.gif', '1') }
    ]
    expect do
      Task::Create.call(
        name: 'Hi!', description: 'Hello!', user_id: user.id,
        attachments: attachments
      )
    end.to raise_error(Trailblazer::Operation::InvalidContract)
  end
end
