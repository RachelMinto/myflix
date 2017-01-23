# Video.create(title: 'Futurama', description: 'Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.', large_cover_url: '/tmp/futurama_large.jpg', small_cover_url: '/tmp/futurama.jpg')
# Video.create(title: 'Justified', description: 'Deputy U.S. Marshal Raylan Givens is something of a 19th-century–style, Old West lawman living in modern times, whose unconventional enforcement of justice makes him a target of criminals and a problem child to his U.S. Marshals Service superior.', large_cover_url: '/tmp/justified_large.jpg', small_cover_url: '/tmp/justified.jpg')
# Video.create(title: 'Sherlock', description: 'Sherlock depicts "consulting detective" Sherlock Holmes (Benedict Cumberbatch) solving various mysteries in modern-day London. Holmes is assisted by his flatmate and friend, Dr John Watson (Martin Freeman), who has returned from military service in Afghanistan with the Royal Army Medical Corps.', large_cover_url: '/tmp/sherlock_large.jpg', small_cover_url: '/tmp/sherlock.jpg')
# Video.create(title: 'Parks and Recreation', description: 'Parks and Recreation focuses on Leslie Knope (Amy Poehler), the deputy director of the Parks and Recreation Department in the fictional Indiana town of Pawnee. Local nurse Ann Perkins (Rashida Jones) demands that a construction pit in the abandoned lot beside her house be filled in after her boyfriend, Andy Dwyer (Chris Pratt), fell in and broke his legs.', large_cover_url: '/tmp/parksrec_large.jpeg', small_cover_url: '/tmp/parksrec.jpg')
# Video.create(title: 'The Venture Bros.', description: 'The Venture Bros. chronicles the lives and adventures of the Venture family: well-meaning but incompetent teenagers Hank and Dean Venture; their emotionally insecure, unethical and under-achieving super-scientist father Dr. Thaddeus "Rusty" Venture; the family\'s bodyguard, secret agent Brock Samson, or his temporary replacement, the reformed villain and pedophile Sergeant Hatred; and the family\'s self-proclaimed arch-nemesis, The Monarch, a butterfly-themed mega villain', large_cover_url: '/tmp/venture_large.jpg', small_cover_url: '/tmp/venture.jpg')
# Video.create(title: 'Monk', description: 'Adrian Monk was a brilliant detective for the San Francisco Police Department until his wife, Trudy, was killed by a car bomb in a parking garage, which Monk then believed was intended for him. In a later episode, he discovers the bomb was truly meant for Trudy. He later believes that Trudy\'s death was part of a larger conspiracy that she had uncovered during her time as a journalist.', large_cover_url: '/tmp/monk_large.jpg', small_cover_url: '/tmp/monk.jpg')
# Video.create(title: '', description: '', large_cover_url: '/tmp/.jpg', small_cover_url: '/tmp/.jpg')

# Category.create(name: 'Comedy')
# Category.create(name: 'Action')
# Category.create(name: 'Mystery')

# futurama = Video.find_by(id: 1)
# futurama.category_id = 1
# futurama.save

justified = Video.find_by(id: 2)
justified.category_id = 2
justified.save

sherlock = Video.find_by(id: 3)
sherlock.category_id = 3
sherlock.save

parks = Video.find_by(id: 4)
parks.category_id = 1
parks.save

venture = Video.find_by(id: 5)
venture.category_id = 1
venture.save

monk = Video.find_by(id: 6)
monk.category_id = 3
monk.save

# Video.find_by(id: 5).category_id = 1
# Video.find_by(id: 6).category_id = 3