Video.create(title: 'Futurama', description: 'Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.', large_cover_url: '/tmp/futurama_large.jpg', small_cover_url: '/tmp/futurama.jpg')
Video.create(title: 'Justified', description: 'Deputy U.S. Marshal Raylan Givens is something of a 19th-century–style, Old West lawman living in modern times, whose unconventional enforcement of justice makes him a target of criminals and a problem child to his U.S. Marshals Service superior.', large_cover_url: '/tmp/justified_large.jpg', small_cover_url: '/tmp/justified.jpg')
Video.create(title: 'Sherlock', description: 'Sherlock depicts "consulting detective" Sherlock Holmes (Benedict Cumberbatch) solving various mysteries in modern-day London. Holmes is assisted by his flatmate and friend, Dr John Watson (Martin Freeman), who has returned from military service in Afghanistan with the Royal Army Medical Corps.', large_cover_url: '/tmp/sherlock_large.jpg', small_cover_url: '/tmp/sherlock.jpg')
Video.create(title: 'Parks and Recreation', description: 'Parks and Recreation focuses on Leslie Knope (Amy Poehler), the deputy director of the Parks and Recreation Department in the fictional Indiana town of Pawnee. Local nurse Ann Perkins (Rashida Jones) demands that a construction pit in the abandoned lot beside her house be filled in after her boyfriend, Andy Dwyer (Chris Pratt), fell in and broke his legs.', large_cover_url: '/tmp/parksrec_large.jpeg', small_cover_url: '/tmp/parksrec.jpg')
Video.create(title: 'The Venture Bros.', description: 'The Venture Bros. chronicles the lives and adventures of the Venture family: well-meaning but incompetent teenagers Hank and Dean Venture; their emotionally insecure, unethical and under-achieving super-scientist father Dr. Thaddeus "Rusty" Venture; the family\'s bodyguard, secret agent Brock Samson, or his temporary replacement, the reformed villain and pedophile Sergeant Hatred; and the family\'s self-proclaimed arch-nemesis, The Monarch, a butterfly-themed mega villain', large_cover_url: '/tmp/venture_large.jpg', small_cover_url: '/tmp/venture.jpg')
Video.create(title: 'Monk', description: 'Adrian Monk was a brilliant detective for the San Francisco Police Department until his wife, Trudy, was killed by a car bomb in a parking garage, which Monk then believed was intended for him. In a later episode, he discovers the bomb was truly meant for Trudy. He later believes that Trudy\'s death was part of a larger conspiracy that she had uncovered during her time as a journalist.', large_cover_url: '/tmp/monk_large.jpg', small_cover_url: '/tmp/monk.jpg')
Video.create(title: '', description: '', large_cover_url: '/tmp/.jpg', small_cover_url: '/tmp/.jpg')

Category.create(name: 'Comedy')
Category.create(name: 'Action')
Category.create(name: 'Mystery')

futurama = Video.find_by(id: 1)
futurama.category_id = 1
futurama.save

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

Video.create(title: 'Clueless', description: 'A rich high school student tries to boost a new pupil\'s popularity, but reckons without affairs of the heart getting in the way.', large_cover_url: '/tmp/clueless_large.jpg', small_cover_url: '/tmp/clueless.jpg', category_id: 1)
Video.create(title: 'Django Unchained', description: 'With the help of a German bounty hunter, a freed slave sets out to rescue his wife from a brutal Mississippi plantation owner.', large_cover_url: '/tmp/django_large.jpg', small_cover_url: '/tmp/django.jpg', category_id: 2)
Video.create(title: 'Hot Fuzz', description: 'Exceptional London cop Nicholas Angel is involuntarily transferred to a quaint English village and paired with a witless new partner. While on the beat, Nicholas suspects a sinister conspiracy is afoot with the residents.', large_cover_url: '/tmp/hotfuzz_large.jpg', small_cover_url: '/tmp/hotfuzz.jpg', category_id: 3)
Video.create(title: 'Inglourious Basterds', description: 'As war rages in Europe, a Nazi-scalping squad of American soldiers, known to their enemy as “The Basterds,” is on a daring mission to take down the leaders of the Third Reich.', large_cover_url: '/tmp/inglouriousbasterds_large.jpg', small_cover_url: '/tmp/inglouriousbasterds.jpg', category_id: 2)
Video.create(title: 'Mad Max: Fury Road', description: 'A woman rebels against a tyrannical ruler in postapocalyptic Australia in search for her home-land with the help of a group of female prisoners, a psychotic worshipper, and a drifter named Max.', large_cover_url: '/tmp/madmax_large.jpg', small_cover_url: '/tmp/madmax.jpg', category_id: 2)
Video.create(title: 'Minority Report', description: 'In a future where a special police unit is able to arrest murderers before they commit their crimes, an officer from that unit is himself accused of a future murder.', large_cover_url: '/tmp/minorityreport_large.jpg', small_cover_url: '/tmp/minority_report.jpg', category_id: 3)
Video.create(title: 'The Office', description: 'A mockumentary on a group of typical office workers, where the workday consists of ego clashes, inappropriate behavior, and tedium. Based on the hit BBC series.', large_cover_url: '/tmp/office_large.jpg', small_cover_url: '/tmp/office.jpg', category_id: 1)
Video.create(title: 'Silver Linings Playbook', description: 'After a stint in a mental institution, former teacher Pat Solitano moves back in with his parents and tries to reconcile with his ex-wife. Things get more challenging when Pat meets Tiffany, a mysterious girl with problems of her own.', large_cover_url: '/tmp/silverlinings_large.jpg', small_cover_url: '/tmp/silverlinings.jpg', category_id: 1)
Video.create(title: 'The Simpsons', description: 'The Simpsons is an American animated sitcom created by Matt Groening for the Fox Broadcasting Company.[1][2][3] The series is a satirical depiction of working-class life epitomized by the Simpson family, which consists of Homer, Marge, Bart, Lisa, and Maggie. ', large_cover_url: '/tmp/simpsons_large.jpg', small_cover_url: '/tmp/simpsons.jpg', category_id: 1)

Review.create(rating: 5, comment: "What a great movie!!", user_id: 1, video_id: 2 )

UserVideo.create(position: 1, user: User.find(1), video: Video.find(4))
UserVideo.create(position: 2, user: User.find(1), video: Video.find(2))
UserVideo.create(position: 3, user: User.find(1), video: Video.find(1))
UserVideo.create(position: 4, user: User.find(1), video: Video.find(5))

