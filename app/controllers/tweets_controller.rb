class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy retweet ]
  before_action :authenticate_user!, except: [:index]

  # GET /tweets or /tweets.json
  def index

    if params[:q]
     @tweets = Tweet.where("content LIKE ?", "%#{params[:q]}%").order(created_at: :desc).page(params[:page])
    else
       @tweets = Tweet.order(created_at: :desc).page(params[:page])
    end
    @tweet = Tweet.new
  end

  # GET /tweets/1 or /tweets/1.json
  def show
  end


  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
    if @tweet.user_id != current_user.id
      redirect_to root_path, alert: 'you dont have permission for edit tweets'
    end
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: "Tweet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def retweet
    @retweet = Tweet.new(
      user_id: current_user.id,
      content: @tweet.content,
     
    )
      if @retweet.save
        redirect_to root_path, notice: 'Retwitteado'
      else
        redirect_to root_path, alert: 'No se pudo retwittear'
      end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content, :user_id, :created_at, :tweet_id)
    end

    def retweet_params
      params.require(:retweet).permit(:retweet_id, :content).merge(user_id: current_user.id)
    end
end
