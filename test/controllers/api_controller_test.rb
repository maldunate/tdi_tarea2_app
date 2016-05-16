require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

	test "return json status code 400 when the is an error" do
		get :buscarTag, {:params => {:tag => 'Santiago', :access_token => '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402'}}
		assert_equal 400, response.status
	end

	test "tagCount return int or false" do 
		#Retorna False cuando el llamado es erroneo
		assert_equal false, @controller.send(:tagCount, 'Santiago', '987'), "Bad Token"
		#Retorna un int cuando está bien realizado el llamado
		assert_not_equal false, @controller.send(:tagCount, 'Santiago', '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402')
	end

	test "arrayPosts return content or false" do
		#Retorna False cuando el llamado es erroneo
		assert_equal false, @controller.send(:arrayPosts, 'Santiago', '987'), "Bad Token"
		#Retorna Contenido cuando el llamado es correcto
		assert_not_equal false, @controller.send(:arrayPosts, 'Santiago', '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402')
	end

	test "buscarTag return results" do
		#Retorna False cuando no se entrega un String
		assert_equal false, @controller.send(:is_json?, "hola"), "debe recibir JSON pero recibe string"
		#Retorna True cuando se entrega un JSON
		assert_equal true, @controller.send(:is_json?, '{"metadata": "hola", "metadata2": 987}')
	end


end
