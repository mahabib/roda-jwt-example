require_relative '00_helper'

class TestAuth < Minitest::Test
	include Rack::Test::Methods

	def app
		App.app
	end

	def setup
		create_test_data
	end

	def test_invalid_general_login
		post "/auth/login", {email: 'aaa', password: 'bbb'}

		assert_equal 500, last_response.status
		data = Utils.indifferent_data(JSON.parse(last_response.body))
		assert data != nil

		assert_equal false, data[:success]
		assert data[:error] != nil
	end

	def test_valid_login
		post "/auth/login", {email: 'habib@mail.com', password: 'habib@mail.com'}

		assert_equal 200, last_response.status
		data = Utils.indifferent_data(JSON.parse(last_response.body))
		assert data != nil

		assert_equal true, data[:success]
		assert data[:values] != nil
		assert data[:values][:token] != nil
		assert data[:values][:exp] != nil

		assert_equal Hash, data[:values][:user].class
		user = data[:values][:user]
		assert user[:name] != nil
		assert user[:email] != nil
	end
end

