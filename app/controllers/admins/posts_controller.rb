class Admins::PostsController < Admins::BaseController
    before_action :get_post, only: [:show]
  
    def index
       @posts = Post.all
      respond_to do |format|
        format.html
        format.json {
          render json: PostDatatable.new(view_context, { recordset: @posts }) }
      end
    end
  
    def new
      @post = Post.new
    end
    def show
      @post = Post.find(params[:id])
    end
  
    private
  
    def get_post
      @post = Post.find_by(id: params[:id])
    end
  end
  