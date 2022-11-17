class CommentsController < ApplicationController
  
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end  

  def edit
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
  end  

  def update
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
      if @comment.update(comment_params)
        flash[:success] = "Object was successfully updated"
        redirect_to @article
      else
        flash[:error] = "Something went wrong"
        render 'edit'
      end
  end
  
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    if @comment.destroy
      flash[:success] = 'Object was successfully deleted.'
      redirect_to article_path(@article)
    else
      flash[:error] = 'Something went wrong'
      redirect_to article_path(@article)
    end
  end
  

  private
    def comment_params
      params.require(:comment).permit(:commentator, :comment)
    end  
end
