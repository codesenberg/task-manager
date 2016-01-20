User.transaction do
  ruby_programmer = User.create!(email: 'rails-programmer@awesome.com', password: 'rubyisawesome')
  ruby_programmer.tasks.create!([
    {
      name: 'Visit www.ruby-lang.org',
      description: 'Go to www.ruby-lang.org and learn about ruby',
      state: :finished
    },
    {
      name: 'Read some books about Ruby',
      description: 'Read the pickaxe book',
      state: :started
    },
    {
      name: 'Write home project',
      description: 'Write a blog application with Rails',
      state: :started
    },
    {
      name: 'Find job',
      description: 'Find an awesome job',
      state: :added
    }
  ])

  haskell_programmer = User.create!(email: 'lambda@the-great.org', password: 'purelyawesome')
  haskell_programmer.tasks.create!([
    {
      name: 'Read The Book',
      description: 'Read "Learn You a Haskell for Great Good!"',
      state: :finished
    },
    {
      name: 'Read about esoteric stuff',
      description: 'Read about monads, applicative functors, monad transformers, etc.',
      state: :finished
    },
    {
      name: 'Become Enlightened',
      description: 'Forget about Haskell. Learn Ruby.',
      state: :started
    }
  ])
end