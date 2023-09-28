# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

field1 = StudyField.create(field_name: 'Physics')
field2 = StudyField.create(field_name: 'Chemistry')

user1 = User.create!(
  email: 'test@test.com',
  first_name: 'John',
  last_name: 'Doe',
  password: '123456',
  orcid_id: '0123-4567-8901-2345',
  study_field_id: 1
)
user2 = User.create!(
  email: 'peter@test.com',
  first_name: 'Peter',
  last_name: 'Parker',
  password: '123456',
  orcid_id: '9876-5432-1098-7654',
  study_field_id: 2
)
user3 = User.create!(
  email: 'joanne@test.com',
  first_name: 'Joanne',
  last_name: 'Archer',
  password: '123456',
)
user4 = User.create!(
  email: 'mark@test.com',
  first_name: 'Mark',
  last_name: 'Smith',
  password: '123456',
)


cat1 = Category.create!(category_name: 'Mathematics')
cat2 = Category.create!(category_name: 'Physics')
cat3 = Category.create!(category_name: 'Chemistry')
cat4 = Category.create!(category_name: 'Biology')
cat5 = Category.create!(category_name: 'Computer Science')
cat6 = Category.create!(category_name: 'Engineering')
cat7 = Category.create!(category_name: 'Economics')
cat8 = Category.create!(category_name: 'Medicine')
cat9 = Category.create!(category_name: 'Psychology')
cat10 = Category.create!(category_name: 'Philosophy')
cat11 = Category.create!(category_name: 'History')
cat12 = Category.create!(category_name: 'Geography')
cat13 = Category.create!(category_name: 'Law')
cat14 = Category.create!(category_name: 'Other')

# Math tags
tag1 = Tag.create!(tag: 'Linear Algebra', category_id: cat1.id)
tag2 = Tag.create!(tag: 'Calculus', category_id: cat1.id)
tag3 = Tag.create!(tag: 'Differential Equations', category_id: cat1.id)
tag4 = Tag.create!(tag: 'Algebra', category_id: cat1.id)
tag5 = Tag.create!(tag: 'Geometry', category_id: cat1.id)
tag6 = Tag.create!(tag: 'Number Theory', category_id: cat1.id)

# Physics tags
tag7 = Tag.create!(tag: 'Mechanics', category_id: cat2.id)
tag8 = Tag.create!(tag: 'Thermodynamics', category_id: cat2.id)
tag9 = Tag.create!(tag: 'Electromagnetism', category_id: cat2.id)
tag10 = Tag.create!(tag: 'Quantum Mechanics', category_id: cat2.id)
tag11 = Tag.create!(tag: 'Relativity', category_id: cat2.id)
tag12 = Tag.create!(tag: 'Astrophysics', category_id: cat2.id)

# Chemistry tags
tag13 = Tag.create!(tag: 'Organic Chemistry', category_id: cat3.id)
tag14 = Tag.create!(tag: 'Inorganic Chemistry' , category_id: cat3.id)
tag15 = Tag.create!(tag: 'Physical Chemistry' , category_id: cat3.id)
tag16 = Tag.create!(tag: 'Analytical Chemistry' , category_id: cat3.id)
tag17 = Tag.create!(tag: 'Biochemistry')


# Biology tags
tag18 = Tag.create!(tag: 'Cellular Biology' , category_id: cat4.id)
tag19 = Tag.create!(tag: 'Molecular Biology' , category_id: cat4.id)
tag20 = Tag.create!(tag: 'Genetics' , category_id: cat4.id)
tag21 = Tag.create!(tag: 'Ecology' , category_id: cat4.id)
tag22 = Tag.create!(tag: 'Evolution' , category_id: cat4.id)
tag23 = Tag.create!(tag: 'Zoology' , category_id: cat4.id)

# Computer Science tags
tag24 = Tag.create!(tag: 'Algorithms' , category_id: cat5.id)
tag25 = Tag.create!(tag: 'Data Structures' , category_id: cat5.id)
tag26 = Tag.create!(tag: 'Programming Languages' , category_id: cat5.id)
tag27 = Tag.create!(tag: 'Operating Systems' , category_id: cat5.id)
tag28 = Tag.create!(tag: 'Computer Architecture' , category_id: cat5.id)
tag29 = Tag.create!(tag: 'Artificial Intelligence' , category_id: cat5.id)

# Engineering tags
tag30 = Tag.create!(tag: 'Mechanical Engineering' , category_id: cat6.id)
tag31 = Tag.create!(tag: 'Electrical Engineering' , category_id: cat6.id)
tag32 = Tag.create!(tag: 'Civil Engineering' , category_id: cat6.id)

# Law tags
tag33 = Tag.create!(tag: 'Criminal Law' , category_id: cat13.id)
tag34 = Tag.create!(tag: 'Civil Law' , category_id: cat13.id)
tag35 = Tag.create!(tag: 'Constitutional Law' , category_id: cat13.id)
tag36 = Tag.create!(tag: 'Administrative Law' , category_id: cat13.id)
tag37 = Tag.create!(tag: 'International Law' , category_id: cat13.id)
tag38 = Tag.create!(tag: 'Tax Law' , category_id: cat13.id)


# article1 = BlogArticle.create!(
#   user_id: user1.id, 
#   title: "PubWeave: Technologies behind it",
#   subtitle: "PubWeave: Technologies behind it",
#   content: [["time", 1693566657621], ["version", "2.28.0"]],
  # content: {
  #   "time": 1693566657621,
  #   "version": "2.28.0",
  #   "blocks": [
  #       {
  #           "id": "vXiTllTy_N",
  #           "type": "paragraph",
  #           "position": 7,
  #           "data": {
  #               "text": "Ruby on Rails, often simply referred to as Rails, is an open-source web application framework written in the Ruby programming language. It was created by David Heinemeier Hansson and first released in 2005. Rails is designed to simplify and streamline the process of building web applications by emphasizing convention over configuration (CoC) and the model-view-controller (MVC) architectural pattern."
  #           },
  #           "version_number": 1.0,
  #           "collaborator_id": null,
  #           "collaborator": null,
  #           "current_editor_id": null,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T10:39:17.754Z"
  #       },
  #       {
  #           "id": "gAELj8zLUI",
  #           "type": "image",
  #           "position": 8,
  #           "data": {
  #               "file": {
  #                   "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/Ruby_On_Rails_Logo.svg/1200px-Ruby_On_Rails_Logo.svg.png"
  #               },
  #               "caption": "Rails image",
  #               "stretched": false,
  #               "withBorder": false,
  #               "withBackground": true
  #           },
  #           "version_number": 1.0,
  #           "collaborator_id": null,
  #           "collaborator": null,
  #           "current_editor_id": null,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T10:39:17.782Z"
  #       },
  #       {
  #           "id": "Sz8pzJdp5C",
  #           "type": "header",
  #           "position": 0,
  #           "data": {
  #               "text": "PubWeave: Technologies behind it",
  #               "level": 1
  #           },
  #           "version_number": 1.0,
  #           "collaborator_id": null,
  #           "collaborator": null,
  #           "current_editor_id": null,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T10:34:06.214Z"
  #       },
  #       {
  #           "id": "Mza8Zp9vMh",
  #           "type": "header",
  #           "position": 20,
  #           "data": {
  #               "text": "References",
  #               "level": 4
  #           },
  #           "version_number": 1.0,
  #           "collaborator_id": null,
  #           "collaborator": null,
  #           "current_editor_id": null,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T11:05:59.577Z"
  #       },
  #       {
  #           "id": "dICE6T6vjc",
  #           "type": "paragraph",
  #           "position": 18,
  #           "data": {
  #               "text": "When a struct that contains content (e.g.\u0026nbsp;\u003ccode\u003e\u003ccode class=\"inline-code\"\u003eItemString\u003c/code\u003e\u003c/code\u003e) is deleted, the struct will be replaced with an\u0026nbsp;\u003ccode\u003e\u003ccode class=\"inline-code\"\u003eItemDeleted\u003c/code\u003e\u003c/code\u003e\u0026nbsp;that does not contain content anymore."
  #           },
  #           "version_number": 1.0,
  #           "collaborator_id": null,
  #           "collaborator": null,
  #           "current_editor_id": null,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T11:05:59.599Z"
  #       },
  #       {
  #           "id": "8pVecpdNpi",
  #           "type": "paragraph",
  #           "position": 22,
  #           "data": {
  #               "text": "\u003ca href=\"https://blog.kevinjahns.de/are-crdts-suitable-for-shared-editing/\"\u003e\u003cb\u003eAre CRDTs suitable for shared editing?\u003c/b\u003e\u003c/a\u003e"
  #           },
  #           "version_number": 1.0,
  #           "collaborator_id": null,
  #           "collaborator": null,
  #           "current_editor_id": null,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T11:06:02.971Z"
  #       },
  #       {
  #           "id": "fvJ5wUvdML",
  #           "type": "paragraph",
  #           "position": 19,
  #           "data": {
  #               "text": "When a type is deleted, all child elements are transformed to\u0026nbsp;\u003ccode\u003eGC\u003c/code\u003e\u0026nbsp;structs. A\u0026nbsp;\u003ccode\u003eGC\u003c/code\u003e\u0026nbsp;struct only denotes the existence of a struct and that it is deleted.\u0026nbsp;\u003ccode\u003eGC\u003c/code\u003e\u0026nbsp;structs can always be merged with other\u0026nbsp;\u003ccode\u003eGC\u003c/code\u003e\u0026nbsp;structs if the id's are adjacent."
  #           },
  #           "version_number": 1.0,
  #           "collaborator_id": null,
  #           "collaborator": null,
  #           "current_editor_id": null,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T11:06:12.943Z"
  #       },
  #       {
  #           "id": "ICYOtgKT4z",
  #           "type": "header",
  #           "position": 11,
  #           "data": {
  #               "text": "Future research -\u0026nbsp;Conflict-free replicated data type (CRDT)",
  #               "level": 3
  #           },
  #           "version_number": 1.0,
  #           "collaborator_id": null,
  #           "collaborator": null,
  #           "current_editor_id": null,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T10:45:36.570Z"
  #       },
  #       {
  #           "id": "9vEk1_cgtY",
  #           "type": "list",
  #           "position": 13,
  #           "data": {
  #               "items": [
  #                   "The application can update any replica independently,\u0026nbsp;concurrently\u0026nbsp;and without\u0026nbsp;coordinating\u0026nbsp;with other replicas.",
  #                   "An algorithm (itself part of the data type) automatically resolves any inconsistencies that might occur.",
  #                   "Although replicas may have different state at any particular point in time, they are guaranteed to eventually converge."
  #               ],
  #               "style": "ordered"
  #           },
  #           "version_number": 1.0,
  #           "collaborator_id": null,
  #           "collaborator": null,
  #           "current_editor_id": null,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T10:46:15.462Z"
  #       },
  #       {
  #           "id": "kjjEmfNe9b",
  #           "type": "inlineImage",
  #           "position": 1,
  #           "data": {
  #               "url": "https://images.unsplash.com/photo-1501504905252-473c47e087f8?crop=entropy\u0026amp;cs=srgb\u0026amp;fm=jpg\u0026amp;ixid=M3w0NTc0Nzh8MHwxfHNlYXJjaHwxfHxhcnRpY2xlfGVufDB8fHx8MTY5MzU2NDY5NHww\u0026amp;ixlib=rb-4.0.3\u0026amp;q=85",
  #               "caption": "",
  #               "stretched": false,
  #               "withBorder": false,
  #               "withBackground": true
  #           },
  #           "version_number": 1.0,
  #           "collaborator_id": 1,
  #           "collaborator": null,
  #           "current_editor_id": 1,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T11:10:57.665Z"
  #       },
  #       {
  #           "id": "Iux0uqwMzN",
  #           "type": "delimiter",
  #           "position": 9,
  #           "data": {},
  #           "version_number": 1.0,
  #           "collaborator_id": null,
  #           "collaborator": null,
  #           "current_editor_id": null,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T10:39:50.689Z"
  #       },
  #       {
  #           "id": "YwrY0McBbu",
  #           "type": "header",
  #           "position": 10,
  #           "data": {
  #               "text": "Real-time integration",
  #               "level": 2
  #           },
  #           "version_number": 1.0,
  #           "collaborator_id": null,
  #           "collaborator": null,
  #           "current_editor_id": null,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T10:55:32.266Z"
  #       },
  #       {
  #           "id": "CD7ssQMzEy",
  #           "type": "paragraph",
  #           "position": 17,
  #           "data": {
  #               "text": "If a user inserts elements in sequence, the struct will be merged into a single struct. E.g.\u0026nbsp;\u003ccode class=\"inline-code\"\u003etext.insert(0, 'a')\u003c/code\u003e, \u003ccode class=\"inline-code\"\u003etext.insert(1, 'b')\u003c/code\u003e;\u0026nbsp;is first\u0026nbsp;represented as two structs (\u003ccode class=\"inline-code\"\u003e[{id: {client, clock: 0}, content: 'a'}, {id: {client, clock: 1}, content: 'b'}]\u003c/code\u003e) and then merged into a single struct:\u0026nbsp;\u003ccode class=\"inline-code\"\u003e[{id: {client, clock: 0}, content: 'ab'}]\u003c/code\u003e."
  #           },
  #           "version_number": 1.0,
  #           "collaborator_id": null,
  #           "collaborator": null,
  #           "current_editor_id": null,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T11:05:28.582Z"
  #       },
  #       {
  #           "id": "Z4PR0bGh2I",
  #           "type": "raw",
  #           "position": 14,
  #           "data": {
  #               "html": "payload integer[n] P\n    initial [0,0,...,0]\nupdate increment()\n    let g = myId()\n    P[g] := P[g] + 1\nquery value() : integer v\n    let v = Σi P[i]\ncompare (X, Y) : boolean b\n    let b = (∀i ∈ [0, n - 1] : X.P[i] ≤ Y.P[i])\nmerge (X, Y) : payload Z\n    let ∀i ∈ [0, n - 1] : Z.P[i] = max(X.P[i], Y.P[i])"
  #           },
  #           "version_number": 1.0,
  #           "collaborator_id": null,
  #           "collaborator": null,
  #           "current_editor_id": null,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T10:46:51.822Z"
  #       },
  #       {
  #           "id": "APcTq8NDuk",
  #           "type": "delimiter",
  #           "position": 2,
  #           "data": {},
  #           "version_number": 1.0,
  #           "collaborator_id": null,
  #           "collaborator": null,
  #           "current_editor_id": null,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T10:38:17.782Z"
  #       },
  #       {
  #           "id": "ISPoSY3t0E",
  #           "type": "header",
  #           "position": 3,
  #           "data": {
  #               "text": "Frontend",
  #               "level": 3
  #           },
  #           "version_number": 1.0,
  #           "collaborator_id": null,
  #           "collaborator": null,
  #           "current_editor_id": null,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T10:38:17.810Z"
  #       },
  #       {
  #           "id": "gKbBIeiixb",
  #           "type": "paragraph",
  #           "position": 4,
  #           "data": {
  #               "text": "React is a JavaScript library for building user interfaces. React was developed by Facebook and is commonly used for creating dynamic and interactive web applications. It provides a declarative way to describe how your UI should look, and it automatically updates and re-renders the UI as data changes."
  #           },
  #           "version_number": 1.0,
  #           "collaborator_id": null,
  #           "collaborator": null,
  #           "current_editor_id": null,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T10:38:22.956Z"
  #       },
  #       {
  #           "id": "CYAgO9xy0y",
  #           "type": "image",
  #           "position": 5,
  #           "data": {
  #               "file": {
  #                   "url": "https://www.datocms-assets.com/14946/1638186862-reactjs.png?auto=format\u0026amp;fit=max\u0026amp;w=1200"
  #               },
  #               "caption": "React image",
  #               "stretched": false,
  #               "withBorder": false,
  #               "withBackground": false
  #           },
  #           "version_number": 1.0,
  #           "collaborator_id": null,
  #           "collaborator": null,
  #           "current_editor_id": null,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T10:38:27.102Z"
  #       },
  #       {
  #           "id": "I25hja_Pu2",
  #           "type": "header",
  #           "position": 6,
  #           "data": {
  #               "text": "Backend",
  #               "level": 3
  #           },
  #           "version_number": 1.0,
  #           "collaborator_id": null,
  #           "collaborator": null,
  #           "current_editor_id": null,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T10:38:27.959Z"
  #       },
  #       {
  #           "id": "yXKvWADdWg",
  #           "type": "paragraph",
  #           "position": 21,
  #           "data": {
  #               "text": "\u003cb\u003e\u003ca href=\"https://www.researchgate.net/publication/310212186_Near_Real-Time_Peer-to-Peer_Shared_Editing_on_Extensible_Data_Types\"\u003eNear Real-Time Peer-to-Peer Shared Editing on Extensible Data\u0026nbsp;Types\u003c/a\u003e:\u003c/b\u003e Petru Nicolaescu, Kevin Jahns, Michael Derntl, and Ralf Klamma. 2016. Near Real-Time Peer-to-Peer Shared Editing on Extensible Data Types. In Proceedings of the 2016 ACM International Conference on Supporting Group Work (GROUP '16). Association for Computing Machinery, New York, NY, USA, 39–49. \u003ca href=\"https://doi.org/10.1145/2957276.2957310\"\u003e\u003cmark class=\"cdx-marker\"\u003ehttps://doi.org/10.1145/2957276.2957310\u003c/mark\u003e\u003c/a\u003e"
  #           },
  #           "version_number": 1.0,
  #           "collaborator_id": 1,
  #           "collaborator": null,
  #           "current_editor_id": 1,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T11:05:59.588Z"
  #       },
  #       {
  #           "id": "JAhKUmCSkv",
  #           "type": "header",
  #           "position": 15,
  #           "data": {
  #               "text": "Yjs - a\u0026nbsp;CRDT implementation",
  #               "level": 4
  #           },
  #           "version_number": 1.0,
  #           "collaborator_id": null,
  #           "collaborator": null,
  #           "current_editor_id": null,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T10:55:54.649Z"
  #       },
  #       {
  #           "id": "6ojiwdYJwu",
  #           "type": "paragraph",
  #           "position": 12,
  #           "data": {
  #               "text": "In\u003cspan\u003e\u0026nbsp;\u003c/span\u003e\u003ca href=\"https://en.wikipedia.org/wiki/Distributed_computing\"\u003edistributed computing\u003c/a\u003e, a\u003cspan\u003e\u0026nbsp;\u003c/span\u003e\u003cb\u003econflict-free replicated data type\u003c/b\u003e\u003cspan\u003e\u0026nbsp;\u003c/span\u003e(\u003cb\u003eCRDT\u003c/b\u003e) is a\u003cspan\u003e\u0026nbsp;\u003c/span\u003e\u003ca href=\"https://en.wikipedia.org/wiki/Data_structure\"\u003edata structure\u003c/a\u003e\u003cspan\u003e\u0026nbsp;\u003c/span\u003ethat is\u003cspan\u003e\u0026nbsp;\u003c/span\u003e\u003ca href=\"https://en.wikipedia.org/wiki/Replication_(computing)\"\u003ereplicated\u003c/a\u003e\u003cspan\u003e\u0026nbsp;\u003c/span\u003eacross multiple computers in a\u003cspan\u003e\u0026nbsp;\u003c/span\u003e\u003ca href=\"https://en.wikipedia.org/wiki/Computer_network\"\u003enetwork\u003c/a\u003e, with the following features:"
  #           },
  #           "version_number": 1.0,
  #           "collaborator_id": null,
  #           "collaborator": null,
  #           "current_editor_id": null,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T10:47:38.852Z"
  #       },
  #       {
  #           "id": "PTNwVcQwyH",
  #           "type": "paragraph",
  #           "position": 16,
  #           "data": {
  #               "text": "Yjs is a high-performance \u003ca href=\"https://en.wikipedia.org/wiki/Conflict-free_replicated_data_type\"\u003e\u003cspan class=\"r-crgep1\"\u003eCRDT\u003c/span\u003e\u003c/a\u003e for building collaborative applications that sync automatically."
  #           },
  #           "version_number": 1.0,
  #           "collaborator_id": null,
  #           "collaborator": null,
  #           "current_editor_id": null,
  #           "active_sections": {
  #               "kjjEmfNe9b": 1,
  #               "yXKvWADdWg": 1
  #           },
  #           "time": "2023-09-01T11:02:53.353Z"
  #       }
  #   ]
  # },
#   description: "Used technologies in creating a real time editor and a publishing site and possible future technologies that are in development",
#   status: 'draft', 
#   article_type: "blog_article",
#   star: false, 
#   category_id: cat5.id,
#   tags: [tag24, tag25]
# )


# art_tag1 = BlogArticleTag.create!(tag_id: 1, blog_article_id: 1)
# art_tag2 = BlogArticleTag.create!(tag_id: 2, blog_article_id: 1)
# art_tag3 = BlogArticleTag.create!(tag_id: 1, blog_article_id: 2)

# comment1 = BlogArticleComment.create!(
#   blog_article_id: article1.id,
#   commenter_id: user3.id,
#   comment: "What is a vector space?"
# )

# comment2 = BlogArticleComment.create!(
#   blog_article_id: article1.id,
#   commenter_id: user4.id,
#   comment: "A vector space is a set of vectors that satisfy certain properties.",
#   reply_to_id: 1
# )


# comment3 = BlogArticleComment.create!(
#   blog_article_id: article2.id,
#   commenter_id: user3.id,
#   comment: "What is animal behavior?",
#   reply_to_id: 2
# )

Admin.create!(email: 'a@a.com', password: '123456')
