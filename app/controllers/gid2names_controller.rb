class Gid2namesController < ApplicationController
  # GET /gid2names
  # GET /gid2names.json
  def index
    @gid2names = Gid2name.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @gid2names }
    end
  end

  # GET /gid2names/1
  # GET /gid2names/1.json
  def show
    @gid2name = Gid2name.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gid2name }
    end
  end

  # GET /gid2names/new
  # GET /gid2names/new.json
  def new
    @gid2name = Gid2name.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gid2name }
    end
  end

  # GET /gid2names/1/edit
  def edit
    @gid2name = Gid2name.find(params[:id])
    @user2gid = User2gid.where("gid=?",@gid2name.id)
  end

  # POST /gid2names
  # POST /gid2names.json
  def create
    @gid2name = Gid2name.new(params[:gid2name])

    respond_to do |format|
      if @gid2name.save
        format.html { redirect_to @gid2name, notice: 'Gid2name was successfully created.' }
        format.json { render json: @gid2name, status: :created, location: @gid2name }
      else
        format.html { render action: "new" }
        format.json { render json: @gid2name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /gid2names/1
  # PUT /gid2names/1.json
  def update
    @gid2name = Gid2name.find(params[:id])

    respond_to do |format|
      if @gid2name.update_attributes(params[:gid2name])
        format.html { redirect_to @gid2name, notice: 'Gid2name was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @gid2name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gid2names/1
  # DELETE /gid2names/1.json
  def destroy
    @gid2name = Gid2name.find(params[:id])
    @gid2name.destroy

    respond_to do |format|
      format.html { redirect_to gid2names_url }
      format.json { head :no_content }
    end
  end
end
