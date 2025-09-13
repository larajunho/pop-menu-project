require "test_helper"

module Api
  module V1
    class ImportsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @file_path = Rails.root.join("data", "restaurant_data.json")
      end

      test "should import restaurants, menus and menu_items successfully" do
        post api_v1_import_restaurants_path, params: { file: fixture_file_upload(@file_path, "application/json") }

        json_response = JSON.parse(response.body)
        assert_response :success
        assert_equal "success", json_response["status"]

       
        assert json_response["logs"].any? { |log| log.include?("Restaurant 'Poppo's Cafe' processed") }

        
        assert Restaurant.exists?(name: "Poppo's Cafe")
        assert Menu.exists?(name: "lunch")
        assert MenuItem.exists?(name: "Burger")
      end

      test "should return error if no file provided" do
        post api_v1_import_restaurants_path
        json_response = JSON.parse(response.body)
        assert_response :bad_request
        assert_equal "fail", json_response["status"]
        assert_includes json_response["logs"].first, "No file provided"
      end

      test "should return error for invalid JSON" do
        invalid_file = Tempfile.new(["invalid", ".json"])
        invalid_file.write("this is not json")
        invalid_file.rewind

        post api_v1_import_restaurants_path, params: { file: Rack::Test::UploadedFile.new(invalid_file.path, "application/json") }

        json_response = JSON.parse(response.body)
        assert_response :unprocessable_entity
        assert_equal "fail", json_response["status"]
        assert_includes json_response["logs"].first, "Invalid JSON format"

        invalid_file.close
        invalid_file.unlink
      end
    end
  end
end
