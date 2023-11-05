class ConsumerController < ApplicationController
    def create
        case permitted_params[:consumer]
        when "kafka"
            kafka = Kafka.new(ENV["KAFKA_ENDPOINT"], client_id: ENV["KAFKA_CLIENT"])
            kafka.deliver_message(JSON.dump(params["data"].as_json), topic: permitted_params[:topic])
        end
        render status: :ok
    end

    def permitted_params
        return params.permit(:consumer, :topic)
    end
end
