class PodcastDatatable
  include ApplicationHelper
  delegate :content_tag, :params, :link_to, :podcast_path, to: :@view
 
  def initialize(view, options = {})
    @view = view
    @options = options
  end
 
  def total_count
    Podcast.count
  end
 
  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: total_count,
      iTotalDisplayRecords: total_count,
      aaData: data
    }
  end
 
  private
 
  def data
    podcasts.map do |podcast|
      [
        podcast.id,
        podcast.title,
        podcast.description,
        link_to('View', podcast_path(podcast), class: 'btn btn-primary', target: '_blank')
      ]
    end
  end
 
  def podcasts
    @podcasts ||= fetch_podcasts
  end
 
  def fetch_podcasts
    podcasts = Podcast.all
    if params[:sSearch].present?
      podcasts = podcasts.where("CAST(id AS TEXT) ILIKE :search OR title ILIKE :search OR description ILIKE :search", search: "%#{params[:sSearch]}%")
    end
    podcasts
  end
end
