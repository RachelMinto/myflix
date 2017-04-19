This is a a netfix clone created using TDD and DRY principles.

##Features

- User authentication using bcrypt
- Payments using Stripe
- Users can send emails inviting friends to join
- Users can add, reorder, or delete videos from their queue
- Users can rate and provide comments on videos
- Users can follow other users
- If a user invites a friend and that friend joins, the user will automatically follow their friend
- Users receive a welcome email upon registration
- Admins can add videos and video images (stored with S3)

Development
- Comprehensive unit, model, and integration test coverage with RSpec and Capybara
- Continuous development using Circle CI
- GitHub workflow
- Uses a unicorn server
- Utilizes sidekiq for email sending
- Uses Raven for monitoring production server errors
- Heroku deployment utilized staging and production servers

Note: Front end was largely provided by Launch School.



