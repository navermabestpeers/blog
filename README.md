# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
====================================================================================================
change articles/show if you do not need to reload the page:-

<div>
  <h1><%= @article.title %></h1>
  <%= turbo_frame_tag 'comment_list' do %>
    <%= render partial: 'comments/comment', collection: @article.comments %>
  <% end %>
  <%= turbo_frame_tag 'comment_form' do %>
    <%= render partial: 'comments/form',  article: @article, comment: @comment %>
  <% end %>
</div>
====================================================================================================================================================================================================================================================================================================================================================================================
comment controller create method 
def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    
    # redirect_to article_path(@article)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @article }
        format.turbo_stream { render turbo_stream: turbo_stream.append('comment_list', partial: 'comments/comment', locals: { comment: @comment }) }
      else
        format.html { render 'articles/show' }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('comment_form', partial: 'comments/form', locals: { comment: @comment }) }
      end
    end
  end  
