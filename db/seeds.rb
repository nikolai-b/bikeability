User.create(email: 'no@nomail.com', password: 'password', password_confirmation: 'password')

School.create!(school_name: 'Test School',address_line_1: 'School Row', address_line_2: 'Headingley', 
               postcode: 'LS...', telephone_number: '0113 2..', teacher_name: "Mr Test", email: 'testteacher@example.com',)

Instructor.create!(name: 'Chris M', email: 'chris.m@example.com', telephone_number: '077...', post_code: 'LS..')
Instructor.create!(name: 'Graham', email: 'graham.m@example.com', telephone_number: '077...', post_code: 'LS..')

EmailTemplate.create!(template_name: "instructor", body: "Test")
