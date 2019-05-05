# frozen_string_literal: true

def create!(model, attrs)
  record = model.create!(attrs)
  puts "Created #{model.name} (#{record.id}):"
  record
end

puts '----------------------------- Seeds started -----------------------------'

user = User.last || create!(User, email: 'admin@mail.com', password: 'admin')

blog = user.blog || create!(
  Blog,
  name: 'Godly blog',
  author: 'Jesus',
  user: user,
  subdomain: 'jesus'
)

post = create!(
  Post,
  title: 'Water to wine. It\'s real, or fantasy?',
  blog: blog
)

container1 = create!(Container, post: post, position: 0)
create!(Element::Image, container: container1, position: 0, size: 6)
create!(Element::Text, container: container1, position: 1, size: 6)

container2 = create!(Container, post: post, position: 1)
create!(Element::Link, container: container2, position: 1, size: 6)

puts '----------------------------- Seeds finished ----------------------------'
