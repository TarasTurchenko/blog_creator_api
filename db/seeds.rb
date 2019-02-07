def create_record(model, attrs)
  record = model.create! attrs
  puts "Created #{model.name}:", record.to_json
  record
end

puts '--------------------------- Seeds started ---------------------------'

blog = Blog.last
blog = create_record(Blog, name: 'Godly blog', author: 'Jesus') unless blog

post = blog.posts.last
post = create_record(Post, title: 'Water to wine. It\'s real, or fantasy?', blog: blog) unless post

containers = post.containers

container_1 = containers.first
container_1 = create_record(Container, post: post, position: 0) unless container_1

container_1_elements_count = container_1.elements.count
if container_1_elements_count < 2
  create_record(Element, container: container_1, position: 0, size: 4, kind: 'image') if container_1_elements_count == 0
  create_record(Element, container: container_1, position: 1, size: 8, kind: 'text')
end

container_2 = containers.second
container_2 = create_record(Container, post: post, position: 1) unless container_2

container_2_elements = container_2.elements
create_record(Element, container: container_2, position: 0, size: 12, kind: 'link') unless container_2_elements.first

puts '--------------------------- Seeds finished ---------------------------'