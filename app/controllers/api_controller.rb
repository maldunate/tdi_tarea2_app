class ApiController < ApplicationController

require 'instagram'
require 'sinatra'

	def findTag
		if(params[:tag] && params[:access_token] && params[:tag].is_a?(String) && params[:access_token].is_a?(String) )
			tag = params[:tag]
			access_token = params[:access_token]
			count = tagCount(tag, access_token)
			array = arrayPosts(tag, access_token)
			if(count && array)
				render json: {
				metadata: {
					total: count
				},
				posts: array,
				version: ENV["version_id"]
			}
			else
				render json: {error: "Error"}, status: 400
			end
		else
			render json: {error: "Error"}, status: 400
		end
	end

	def arrayPosts(tag, access_token)
		response = requestWeb('GET', 'https://api.instagram.com/v1/tags/'<<tag.to_s<<'/media/recent'<<'?access_token='<<access_token.to_s)
		if(response == false)
			return false
		else
			arrayResponse= Array.new
			postsObtained = response["data"]

			postsObtained.each do |post|
				if post["type"]=="image"
					hash = {
					tags: post["tags"],
					username: post["user"]["username"],
					likes: post["likes"]["count"].to_i,
					url: post["images"]["standard_resolution"]["url"].to_s,
					caption: post["caption"]["text"].to_s 
				}
				arrayResponse.append(hash)
				elsif post["type"]=="video"
					hash = {
					tags: post["tags"],
					username: post["user"]["username"],
					likes: post["likes"]["count"].to_i,
					url: post["images"]["standard_resolution"]["url"].to_s,
					caption: post["caption"]["text"].to_s 
				}
				arrayResponse.append(hash)
				end
			end
			return arrayResponse
		end	
	end

	def tagCount(tag, access_token)
		response = requestWeb('GET', 'https://api.instagram.com/v1/tags/'<<tag.to_s<<'?access_token='<<access_token.to_s)
		if(response==false)
			return false
		else
			count = response["data"]["media_count"].to_i
			return count
		end
	end

	def requestWeb(typeOfRequest, uri)
		headers = {}
		query = Hash.new
		response

		if typeOfRequest.start_with?('GET')
			response =HTTParty.get(uri, :query => query, :headers => headers)
			return false unless is_json?(response.body.to_s)
		else
			return false
		end

		if(response.code < 300)
			return JSON.parse(response.body)
		else
			return false
		end
	end


	def is_json?(foo)
	    begin
	      return false unless foo.is_a?(String)
	      return JSON.parse(foo).all?
	    rescue JSON::ParserError
	      false
	    end 
	end

	helper_method :prueba 
	helper_method :requestWeb
	helper_method :tagCount
	helper_method :arrayPosts
	helper_method :is_json?
end
