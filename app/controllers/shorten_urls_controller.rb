class ShortenUrlsController < ApplicationController
    before_action :find_url, only: [:show, :shortened]
    skip_before_action :verify_authenticity_token

    def index
        @url = ShortenUrl.new
    end

    def show
        @all = ShortenUrl.all
    end

    def create
        @url = ShortenUrl.new
        @url.original_url = params[:original_url]
        @url.sanitize
        if @url.new_url?
            if @url.save
                shortened_url = @url.shortened_url
                message = "Link shortened"
                # status = 200
            end
        else
            short_url = ShortenUrl.find_by_original_url(@url.original_url)
            if (Time.now() >= short_url.expire_on)
                shortened_url = short_url.shortened_url
                message = "URL not found or expired"
                # status = 404
            else
                shortened_url = short_url.shortened_url
                message = "Link already exists on table"
                #status = 409
            end
        end
        render json: {original_url: @url.original_url,
            shortened_url: shortened_url,
                      message: message}
    end

    def analytics
        short_url_str = params["short_url"].squish
        array = short_url_str.split(":")
        @doc = ShortenUrl.find_by_shortened_url(array[1])
        update_doc = @doc.update("number_of_clicks" => @doc.number_of_clicks + 1)
        @doc.save
    end

    def shortened
        @url = ShortenUrl.find_by_shortened_url(params[:short_url])
        host = request.host_with_port
        @original_url = @url.sanitize_url
        @short_url = host + '/' + @url.shortened_url
    end

    def fetch_original_url
        fetch_url = ShortenUrl.find_by_shortened_url(params[:short_url])
        redirect_to fetch_url.sanitize_url
    end

    private
    def find_url
        params[:short_url] = params[:id] if params[:id]
        @url = ShortenUrl.find_by_shortened_url(params[:short_url]) 
    end

    def url_params
        params.require(:url).permit(:original_url)
    end

end
