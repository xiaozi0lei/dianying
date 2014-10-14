class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def index
#    @user = User.find(params[:user][:id])
    @articles = Article.paginate(:page => params[:page], :per_page => 10, :order => 'created_at DESC')
  end

  def create
    @article = Article.new(article_params)
    
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
   
    if @article.update_attributes(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end

    def user_params
      params.require(:user).permit(:email, :password)
    end
end
