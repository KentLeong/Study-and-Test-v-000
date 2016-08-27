user = User.create(username: "test", password: "123456")
test1 = Test.create(name: "PreAlgebra", user_id: user.id, description: "Test your knowledge in PreAlgebra!")
test1 = Test.create(name: "Algebra", user_id: user.id, description: "Test your knowledge in Algebra!")
study1 = Study.create(name: "study1", test_id: test1.id)
