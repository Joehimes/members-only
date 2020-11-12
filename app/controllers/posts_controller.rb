class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

    def index
        @posts = Post.all
    end

    def new
        @post = Post.new
    end

    def create
        @post = current_user.posts.build(post_params)

        if @post.save
            flash[:notice] = 'Post successful!'
            redirect_to root_path
        else
            flash.now[:alert] = 'There was an error with your post.'
            render 'new'
        end
    end

    private

        def post_params
            params.require(:post).permit(:body)
        end

end
