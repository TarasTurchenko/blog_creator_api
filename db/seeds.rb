# frozen_string_literal: true

def create_record(model, attrs)
  record = model.create! attrs
  puts "Created #{model.name}:", record.to_json
  record
end

puts '----------------------------- Seeds started -----------------------------'

blog = create_record(Blog, name: 'Godly blog', author: 'Jesus')

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
  size: 4,
  kind: 'image'
)

create_record(
  Element,
  container: container1,
  position: 1,
  size: 8,
  kind: 'text'
)

container2 = create_record(Container, post: post, position: 1)

create_record(
  Element,
  container: container2,
  position: 0,
  size: 4,
  kind: 'blank'
)

create_record(
  Element,
  container: container2,
  position: 1,
  size: 8,
  kind: 'link'
)

puts '----------------------------- Seeds finished ----------------------------'
