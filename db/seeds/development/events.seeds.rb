user = User.create(email: "foobar@foo.bar")

description = """Lorem ipsum dolor sit amet, consectetur adipisicing elit.
Officia, quam, eos, repellendus ut sint dolorem quod illum quasi sed odit delectus
eius quisquam possimus iure fugit nisi totam laborum blanditiis!"""
event = Event.create(name: "Foo", description: description)
event.invitations.create(user_id: user.id)

event.event_dates.create(start: Time.new(2013, 9, 24, 16, 30).to_i, end: Time.new(2013, 9, 24, 20, 30).to_i)
event.event_dates.create(start: Time.new(2013, 9, 25, 18, 30).to_i, end: Time.new(2013, 9, 25, 22, 30).to_i)
event.event_dates.create(start: Time.new(2013, 9, 30, 16, 30).to_i, end: Time.new(2013, 9, 30, 20, 30).to_i)

EventToken.create(event_id: event.id, user_id: user.id, token: "foobar")
