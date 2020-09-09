require 'date'
class ShortendedUrlsController < ApplicationController
  before_action :find_url, only: [:show, :shortenend]
  skip_before_action :verify_authenticity_token

  def index
    @url = ShortendedUrl.new
  end

  def show
    if Date.parse(@url.created_at.strftime("%d-%m-%Y")) + 30.day > Date.today
      redirect_to @url.original_url
    else
      render :file => "#{Rails.root}/public/404"
    end
  end

  def create
    @url = ShortendedUrl.new
    @url.original_url = params[:original_url]
    if @url.new_url?
      if @url.save
        redirect_to shortended_path(@url.short_url)

      else
        flash[:error] = "Check the error Below"
        render 'index'
      end
    else
      flash[:notice] = "A short link for this URL is already  in our DB"
      redirect_to shortended_path(@url.find_duplicate.short_url)
    end
  end

def shortended
  @url = ShortendedUrl.find_by_short_url(params[:short_url])
  host = request.host_with_port
  @original_url = @url.original_url
  @short_url = host + '/' + @url.short_url
end

def fetch_original_url
  fetch_url = ShortendedUrl.find_by_short_url(params[:short_url])
  redirect_to fetch_url.original_url
end

private
def find_url
  @url = ShortendedUrl.find_by_short_url(params[:short_url])
end

def url_params
  params.require(:url).permit(:original_url)
end
end
