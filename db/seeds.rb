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

cont1 = create_record(Container, post: post, position: 0)

create_record(
  Element,
  container: cont1,
  position: 0,
  size: 4,
  kind: 'image'
)

create_record(
  Element,
  container: cont1,
  position: 1,
  size: 8,
  kind: 'text'
)

cont2 = create_record(Container, post: post, position: 1)

create_record(
  Element,
  container: cont2,
  position: 0,
  size: 12,
  kind: 'link'
)

puts '----------------------------- Seeds finished ----------------------------'
