class ApiController < ActionController::API

    def news
      @tweets = Tweet.all.order("created_at DESC").limit(50)
      render json: @tweets
    end

    def search
        @tweets = Tweet.where('created_at BETWEEN ? AND ?', params[:fecha1], params[:fecha2])
        render json: @tweets
    end

end
