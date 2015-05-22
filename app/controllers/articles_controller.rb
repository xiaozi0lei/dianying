class ArticlesController < ApplicationController

  before_filter :permission_check, only: [ :new, :create, :edit, :update, :destroy ]

  def new
    @article = Article.new
  end

  def index
    # Add the index page count to the first article
    impressionist Article.find(1) if Article.first
    # Get the total visit times
    @article_sum = Article.sum :impressions_count
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
    # track article action visit counter
    impressionist(@article)
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

    def permission_check
      if current_user.nil? || current_user.id > 2
        redirect_to articles_path
      end
    end

    def article_params
      params.require(:article).permit(:title, :text, :tag_list, :picture, :user_id, :sticky)
    end

end
