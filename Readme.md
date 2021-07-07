
# Requirements
  This is a ruby project so make sure you've ruby installed in your system before you proceed.
  Also remember that the ruby version should be *< 3*.

# Setup
  1. Create a `.env.rb` file in the project root directory and paste the content from `.env.example.rb`.
  2. Open your terminal/command prompt and run the `bundle install` from project root directory.
  3. Migrate the tables and seed the data to the development database by executing following,
    `rake dev_up`
    `rake dev_seed`
  4. Run the application using,
    `rake dev_server`
  5. Go to your web browser and open `http://localhost:9292/users` (if you've changed the port in the `.env.rb` file then use that port instead of 9292)

# Available APIs/Routes
URL / ENDPOINT    |    VERB    |    DESCRIPTION   |     PAYLOAD
----------------- | ---------- | ---------------- | ----------------------------------------------------------------------------
/auth/login       |    POST    | Generate token   | body (form-data) - { "email": "habib@mail.com", "password": "habib@mail.com" }
/users            |    POST    | Create user      | body (raw) - { "name": "John", "email": "john@mail.com", "password": "john@mail.com", "gender": "Male" }
/users            |    GET     | Return all users | 
/users/{id}       |    GET     | Return user      | 
/users/{id}       |    PUT     | Update user      | body (form-data) - { "name": "Ahsan Habib" }
/users/{id}       |   DELETE   | Destroy user     | 

# Rake tasks that are available
- *rake dev_up*       - Migrate development database to latest version
- *rake dev_down*     - Migrate development database to all the way down
- *rake dev_bounce*   - Migrate development database all the way down and then back up
- *rake dev_irb*      - Open irb shell in development mode
- *rake dev_seed*     - Seed development database
- *rake dev_server*   - run app via thin in 'development'

- *rake test_up*      - Migrate test database to latest version
- *rake test_down*    - Migrate test database all the way down
- *rake test_bounce*  - Migrate test database all the way down and then back up
- *rake test_irb*     - Open irb shell in test mode

- *rake prod_up*      - Migrate production database to latest version
- *rake prod_irb*     - Open irb shell in production mode

- *rake app:t*        - test by test name: rake app:t test_invalid_general_login
- *rake app:tt*       - test by number & name: rake app:tt 01 test_invalid_general_login
- *rake app:test*     - to test all apis
