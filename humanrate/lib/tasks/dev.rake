namespace :dev do
  desc 'Creates sample data for local development'
  task prime: ['db:setup'] do
    unless Rails.env.development?
      raise 'This task can only be run in the development environment'
    end

    create_talks
    create_votes
  end

  def create_talks
    puts 'Generating talks'

    talks = [
      { name: 'De PHP à Ruby', description: 'Sans les mains' },
      { name: 'De Ruby à PHP', description: 'Sans les dents'}
    ]

    talks.each do |talk|
      Talk.create(talk)
    end
  end

  def create_votes
    puts 'Generating random votes'

    Talk.all.each do |talk|
      rand(0..5).times do
        Vote.create(note: rand(1..10), talk: talk)
      end
    end
  end
end
