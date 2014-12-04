class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    if session[:user_id] == nil
        redirect_to article_path(@article), :notice => "Please Sign in to comment."
    else
      @comment = @article.comments.create(comment_params)
      current_user.send_message(@article.user, comment_params[:body], comment_params[:commenter])
      redirect_to article_path(@article)
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params[:comment][:commenter] = session[:user_name]
      params.require(:comment).permit(:commenter, :body)
    end
end
