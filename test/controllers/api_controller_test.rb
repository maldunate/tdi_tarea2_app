require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

	#Probar metodo buscarTag
	test "return json status code 400 when the is an error" do
		get :buscarTag, {:params => {:tag => 'piscina', :access_token => '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402'}}
		assert_equal 400, response.status
	end
		
	#Probar Método Request Web
	test "requestWeb return content or false" do
		#Retorna False cuando el llamado es erroneo. Con método incorrecto
		assert_equal false, @controller.send(:requestWeb, 'POST', 'http://google.com'), "No recibe POST"
		#Retorna False cuando el llamado es erroneo. Con URL NO Json
		assert_equal false, @controller.send(:requestWeb, 'GET', 'http://google.com'), "No recibe POST"
		#Retorna Json Content cuando los parámetros están correctos.
		assert_not_equal false,  @controller.send(:requestWeb, 'GET', 'https://api.instagram.com/v1/tags/piscina?access_token=2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402')
	end


	#Probar Método tagCount
	test "tagCount return int or false" do 
		#Retorna False cuando el llamado es erroneo
		assert_equal false, @controller.send(:tagCount, 'piscina', '1'), "Bad Token"
		#Retorna un int cuando está bien realizado el llamado
		assert_not_equal false, @controller.send(:tagCount, 'piscina', '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402')
	end

	#Probar Método Array Posts
	test "arrayPosts return content or false" do
		#Retorna False cuando el llamado es erroneo
		assert_equal false, @controller.send(:arrayPosts, 'piscina', '1'), "Bad Token"
		#Retorna Contenido cuando el llamado es correcto
		assert_not_equal false, @controller.send(:arrayPosts, 'piscina', '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402')
	end

	#Probar Método is Json
	test "buscarTag return results" do
		#Retorna False cuando no se entrega un String
		assert_equal false, @controller.send(:is_json?, 1), "Recibe un Int, por tanto debe ser false"
		#Retorna True cuando se entrega un JSON
		assert_equal true, @controller.send(:is_json?, '{"metadata": "prueba", "metadata2": 2}')
	end


end
