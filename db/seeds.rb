# frozen_string_literal: true

def create_record(model, attrs)
  record = model.create! attrs
  puts "Created #{model.name}:", record.to_json
  record
end

puts '----------------------------- Seeds started -----------------------------'

blog = Blog.last
unless blog
  params = { name: 'Godly blog', author: 'Jesus' }
  blog = create_record(Blog, params)
end

post = blog.posts.last
unless post
  params = { title: 'Water to wine. It\'s real, or fantasy?', blog: blog }
  post = create_record(Post, params)
end

conts = post.containers

cont1 = conts.first
unless cont1
  params = { post: post, position: 0 }
  cont1 = create_record(Container, params)
end

cont1_els_count = cont1.elements.count
if cont1_els_count < 2
  if cont1_els_count.zero?
    params = {
      container: cont1,
      position: 0,
      size: 4,
      kind: 'image'
    }
    create_record(Element, params)
  end
  params = {
    container: cont1,
    position: 1,
    size: 8,
    kind: 'text'
  }
  create_record(Element, params)
end

cont2 = conts.second
unless cont2
  params = { post: post, position: 1 }
  cont2 = create_record(Container, params)
end

cont2_els = cont2.elements
unless cont2_els.first
  params = {
    container: cont2,
    position: 0,
    size: 12,
    kind: 'link'
  }
  create_record(Element, params)
end

puts '----------------------------- Seeds finished ----------------------------'
