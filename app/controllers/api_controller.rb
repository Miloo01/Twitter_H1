class ApiController < ActionController::API
    

    def news
      @tweets = Tweet.all.order("created_at DESC").limit(50)
      render json: @tweets
    end

    def search
        @tweets = Tweet.where('created_at BETWEEN ? AND ?', params[:fecha1], params[:fecha2])
        render json: @tweets
    end

    def create_tweet
        @user = User.find_by(email: request.headers["X-EMAIL"])
        if @user.present?
            @tweeet = Tweeet.new(tweeet: request.headers["X-CONTENT"], user: @user)
            if @tweeet.save
                render json: @tweeet
            else
                render json: "Api Key not valid"
            end
        else
            render json: "User not found"
        end
    end

    

end
