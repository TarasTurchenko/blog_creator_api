# frozen_string_literal: true

def create_record(model, attrs)
  record = model.create! attrs
  puts "Created #{model.name}:", record.to_json
  record
end

puts '----------------------------- Seeds started -----------------------------'

user = User.last || create_record(User, email: 'admin@mail.com', password: 'admin')

blog = create_record(Blog, name: 'Godly blog', author: 'Jesus', user: user)

post = create_record(
  Post,
  title: 'Water to wine. It\'s real, or fantasy?',
  blog: blog
)

container1 = create_record(Container, post: post, position: 0)

create_record(
  Element,
  container: container1,
  position: 0,
  size: 6,
  kind: 'image'
)

create_record(
  Element,
  container: container1,
  position: 1,
  size: 6,
  kind: 'text'
)

container2 = create_record(Container, post: post, position: 1)

create_record(
  Element,
  container: container2,
  position: 0,
  size: 6,
  kind: 'blank'
)

create_record(
  Element,
  container: container2,
  position: 1,
  size: 6,
  kind: 'link'
)

puts '----------------------------- Seeds finished ----------------------------'
