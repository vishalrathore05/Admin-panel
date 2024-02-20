class PodcastDatatable
  delegate :content_tag, :params, :link_to, :edit_admins_podcast_path, :admins_podcast_path, to: :@view

  def initialize(view, options = {})
    @view = view
    @options = options
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: @options[:recordset].count,
        iTotalDisplayRecords: @options[:recordset].count, # Change here
        aaData: data
    }
  end


  private

  def data
    podcasts.map do |podcast|
      [
          content_tag(:div) do
            content = ""
            content += link_to("#{podcast.title}", admins_podcast_path(podcast.id), class: 'text-black')
            content.html_safe
          end,
          content_tag(:div) do
            content = ''
            content += link_to("Edit", edit_admins_podcast_path(podcast), class: 'btn btn-sm btn-primary mr-2')
            content += link_to("Delete", admins_podcast_path(podcast), class: 'btn btn-sm btn-danger', method: :delete, data: { confirm: "Are you sure you want to delete this Announcement?" })
            content.html_safe
          end
      ]
    end
  end

  def podcasts
    @podcasts ||= fetch_podcasts.reorder("#{sort_column} #{sort_direction}")
  end

  def fetch_podcasts
    podcasts = Podcast.all
    if params[:sSearch].present?
      podcasts = podcasts.where("LOWER(title) LIKE :search", search: "%#{params[:sSearch]}%")
    end
    podcasts
  end

  def sort_column
    columns = %w[title position status]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
