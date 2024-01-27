class PostDatatable
    include ApplicationHelper
   delegate :content_tag, :params, :image_tag, :link_to, :admins_post_path, to: :@view
 
   def initialize(view, options = {})
     @view = view
     @options = options
   end
 
    def total_count
      # code here
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
     posts.map do |post|
       [
         post.id,
         post.title,
         post.content,
         content_tag(:div) do
           content = ''
           content += "<span class='text-uppercase p-1'>"
           content += link_to "view", admins_post_path(post), method: :get, class: "text-success"
           content += '</span>'
           content.html_safe
         end
       ]
     end
   end
 
   def posts
     @posts ||= fetch_posts
   end
 
   def fetch_posts
     posts = Post.all  # Change this to your actual User model or query
     if params[:sSearch].present?
       posts = posts.where("CAST(id AS TEXT) ILIKE :search OR user_name ILIKE :search OR full_name ILIKE :search OR CAST(phone_no AS TEXT) ILIKE :search OR email ILIKE :search OR CAST(status AS TEXT) ILIKE :search", search: "%#{params[:sSearch]}%")
     end
     posts
   end
 end