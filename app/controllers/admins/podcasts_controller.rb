 class Admins::PodcastsController < Admins::BaseController

   def index
     @podcasts = Podcast.all
     respond_to do |format|
       format.html
       format.json {
         render json: PodcastDatatable.new(view_context, { recordset: @podcasts })
       }
     end
   end

     def new
       @podcast = Podcast.new
     end

     def create
       @podcast = Podcast.new(podcast_params)

       if @podcast.save
         redirect_to podcasts_path, notice: 'Podcast was successfully created.'
       else
         render :new
       end
     end

     def edit
       @podcast = Podcast.find(params[:id])
     end

   def show
     @podcast = Podcast.find(params[:id])
   end

     def update
       if @podcast.update(podcast_params)
         redirect_to podcasts_path, notice: "Podcast was successfully updated."
       else
         render :edit
       end
     end

     def destroy
       @podcast.destroy
       redirect_to podcasts_path, notice: 'Podcast was successfully destroyed.'
     end

     private

     def set_podcast
       @podcast = Podcast.find_by(id: params[:id])
     end

     def podcast_params
       params.require(:podcast).permit(:image, :audio, :audio_url, :title, :description, :position, :is_active, :podcast_id)
     end
end
