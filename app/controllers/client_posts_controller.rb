# -*- encoding : utf-8 -*-
class ClientPostsController < ApplicationController
  # GET /client_posts
  # GET /client_posts.json
  def index
    @client_posts = params[:cl_id].nil? ? ClientPost : ClientPost.where(cl_id: params[:cl_id])
    @client_posts = @client_posts.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 30, :page => params[:page])
    @client = Client.find(params[:cl_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @client_posts }
    end
  end

  # GET /client_posts/1
  # GET /client_posts/1.json
  def show
    @client_post = ClientPost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client_post }
    end
  end

  # GET /client_posts/new
  # GET /client_posts/new.json
  def new
    @client_post = ClientPost.new
    @client = Client.find(params[:cl_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client_post }
    end
  end

  # GET /client_posts/1/edit
  def edit
    @client_post = ClientPost.find(params[:id])
    @client = Client.find(params[:cl_id])
  end

  # POST /client_posts
  # POST /client_posts.json
  def create
    @client_post = ClientPost.new(params[:client_post])
    @client_post.staff_id = @staff_login.id

    respond_to do |format|
      if @client_post.save
        format.html { redirect_to client_posts_path(:cl_id => params[:cl_id]), notice: 'Заметка добавлена.' }
        format.json { render json: @client_post, status: :created, location: @client_post }
      else
        format.html { render action: "new" }
        format.json { render json: @client_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /client_posts/1
  # PUT /client_posts/1.json
  def update
    @client_post = ClientPost.find(params[:id])

    respond_to do |format|
      if @client_post.update_attributes(params[:client_post])
        format.html { redirect_to client_posts_path(:cl_id => params[:cl_id]), notice: 'Client post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_posts/1
  # DELETE /client_posts/1.json
  def destroy
    @client_post = ClientPost.find(params[:id])
    @client_post.destroy

    respond_to do |format|
      format.html { redirect_to client_posts_url }
      format.json { head :no_content }
    end
  end

  def sort_column
    ClientPost.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
