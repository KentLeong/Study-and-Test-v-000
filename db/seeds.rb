user = User.create(username: "test", password: "123456")
test1 = Test.create(name: "test1", user_id: user.id)
study1 = Study.create(name: "study1", test_id: test1.id)
