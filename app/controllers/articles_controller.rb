class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def index
    # 获取所有的tags
    tag_cloud
    if params[:tag]
      # 获取带有对应tag的文章,并按倒叙排列
      @articles1 = Article.where("user_id = 1").tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 15, :order => 'sticky DESC, created_at DESC')
      @articles2 = Article.where("user_id = 2").tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 15, :order => 'sticky DESC, created_at DESC')
    else
      @articles1 = Article.where("user_id = 1").paginate(:page => params[:page], :per_page => 15, :order => 'sticky DESC, created_at DESC')
      @articles2 = Article.where("user_id = 2").paginate(:page => params[:page], :per_page => 15, :order => 'sticky DESC, created_at DESC')
    end
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
    search
    @article = Article.find(params[:id])
    if request.path != article_path(@article)
      redirect_to @article, status: :moved_permanently
    end
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

  def tag_cloud
    @tags = Article.tag_counts_on(:tags)
  end

  def search
    tag_cloud
    @search = Article.search do
      fulltext params[:search]
      facet(:publish_month)
      with(:publish_month, params[:month]) if params[:month].present?
      paginate :page => 1, :per_page => 300
    end
    @articles = @search.results
  end
  
  private
    def article_params
      params.require(:article).permit(:title, :text, :tag_list, :picture, :user_id, :sticky)
    end

    def user_params
      params.require(:user).permit(:email, :password)
    end
end
