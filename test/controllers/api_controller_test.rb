require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

	test "retorna error 400 si no encuentra el tag" do
		get :buscarTag, {:params => {:tag => 'chile', :access_token => '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402'}}
		assert_equal 400, response.status
	end

	test "tagCount return int or false" do 
		assert_equal false, @controller.send(:tagCount, 'chile', '987'), "Bad Token"
		assert_not_equal false, @controller.send(:tagCount, 'chile', '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402')
	end

	test "arrayPosts return content or false" do
		assert_equal false, @controller.send(:arrayPosts, 'chile', '987'), "Bad Token"
		assert_not_equal false, @controller.send(:arrayPosts, 'chile', '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402')
	end

	test "buscarTag1" do
		assert_equal false, @controller.send(:is_json?, "hola"), "debe recibir JSON pero recibe string"
	end


	test "buscarTag2" do
		assert_equal true, @controller.send(:is_json?, '{"metadata": "hola", "metadata2": 987}')
	end

	test "requestWeb1" do
		assert_not_equal false,  @controller.send(:requestWeb, 'GET', 'https://api.instagram.com/v1/tags/piscina?access_token=2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402')
	end

	test "requestWeb2" do
		assert_equal false, @controller.send(:requestWeb, 'GET', 'http://google.com'), "No recibe POST"
	end


	test "requestWeb3" do
		assert_equal false, @controller.send(:requestWeb, 'POST', 'http://google.com'), "No recibe POST"
	end

end
