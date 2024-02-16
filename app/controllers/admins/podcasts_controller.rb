 class Admins::PodcastsController < Admins::BaseController

  before_action :set_podcast, only: [:show, :edit, :update, :destroy]

  def index
    @podcasts = Podcast.all
    respond_to do |format|
      format.html
      format.json {
        render json: PostDatatable.new(view_context, { recordset: @posts }) }
    end
  end

  def show
  end

  def new
    @podcast = Podcast.new
  end

  def edit
  end

  def create
    @podcast = Podcast.new(podcast_params)

    if @podcast.save
      redirect_to @podcast, notice: 'Podcast was successfully created.'
    else
      render :new
    end
  end

  def update
    if @podcast.update(podcast_params)
      redirect_to @podcast, notice: 'Podcast was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @podcast.destroy
    redirect_to podcasts_url, notice: 'Podcast was successfully destroyed.'
  end

  private
    def set_podcast
      @podcast = Podcast.find(params[:id])
    end

    def podcast_params
      params.require(:podcast).permit(:title, :description, :podcast_id)
    end
end
