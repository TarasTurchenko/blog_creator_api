def print_blog(blog, *posts)
  puts "Blog #{blog} with posts #{posts} created"
end

def print_post(post, *containers)
  puts "Post #{post} with containers #{containers} created"
end

blog1 = Blog.create! name: 'Test blog', author: 'Me'
blog2 = Blog.create! name: 'Second blog', author: 'Me, again'

post1 = Post.create! title: 'My first post', blog: blog1
post2 = Post.create! title: 'My second post', blog: blog1
post3 = Post.create! title: 'Test', blog: blog2

container1 = Container.create! position: 0, post: post1
container2 = Container.create! position: 1, post: post1
container3 = Container.create! position: 2, post: post1

container4 = Container.create! position: 0, post: post2
container5 = Container.create! position: 0, post: post2
container6 = Container.create! position: 0, post: post2

container7 = Container.create! position: 0, post: post3
container8 = Container.create! position: 1, post: post3
container9 = Container.create! position: 0, post: post3

print_blog blog1.id, post1.id, post2.id
print_post post1.id, container1.id, container2.id, container3.id
print_post post2.id, container4.id, container5.id, container6.id

print_blog blog2.id, post3.id
print_post post3.id, container7.id, container8.id, container9.id
