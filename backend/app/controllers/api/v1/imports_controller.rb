module Api
    module V1
      class ImportsController < ApplicationController
        def create
          file = params[:file]
  
          unless file && file.content_type == "application/json"
            render json: { error: "Please upload a JSON file" }, status: :unprocessable_entity
            return
          end
  
          begin
            data = JSON.parse(file.read)
            logs = ImportService.new(data).call
            render json: { logs: logs, status: "success" }
          rescue JSON::ParserError => e
            render json: { error: "Invalid JSON: #{e.message}" }, status: :unprocessable_entity
          end
        end
      end
    end
  end
  
