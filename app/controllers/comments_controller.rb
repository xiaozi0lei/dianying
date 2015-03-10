class CommentsController < ApplicationController
  def create
    c_p = comment_params
    @article = Article.find(params[:article_id])

    @comment = @article.comments.create(c_p)
    # send message to the article author
    if current_user.nil?
      fakeUser = User.new
      fakeUser.send_message(@article.user, c_p[:body], c_p[:commenter])
    else
      current_user.send_message(@article.user, c_p[:body], c_p[:commenter])
    end
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params[:comment][:commenter] = current_user.name unless current_user.nil?
      if params[:comment][:commenter].nil? || params[:comment][:commenter].blank?
        params[:comment][:commenter] = "Anonymous"
      end
      params.require(:comment).permit(:commenter, :body)
    end
end
