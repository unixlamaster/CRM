class TtmsfilesController < ApplicationController
  # GET /ttmsfiles
  # GET /ttmsfiles.json
  def index
    @ttmsfiles = Ttmsfile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ttmsfiles }
    end
  end

  # GET /ttmsfiles/1
  # GET /ttmsfiles/1.json
  def show
    @ttmsfile = Ttmsfile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ttmsfile }
    end
  end

  # GET /ttmsfiles/new
  # GET /ttmsfiles/new.json
  def new
    @ttmsfile = Ttmsfile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ttmsfile }
    end
  end

  # GET /ttmsfiles/1/edit
  def edit
    @ttmsfile = Ttmsfile.find(params[:id])
  end

  # POST /ttmsfiles
  # POST /ttmsfiles.json
  def create
    @ttmsfile = Ttmsfile.new(params[:ttmsfile])

    respond_to do |format|
      if @ttmsfile.save
        format.html { redirect_to @ttmsfile, notice: 'Ttmsfile was successfully created.' }
        format.json { render json: @ttmsfile, status: :created, location: @ttmsfile }
      else
        format.html { render action: "new" }
        format.json { render json: @ttmsfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ttmsfiles/1
  # PUT /ttmsfiles/1.json
  def update
    @ttmsfile = Ttmsfile.find(params[:id])

    respond_to do |format|
      if @ttmsfile.update_attributes(params[:ttmsfile])
        format.html { redirect_to @ttmsfile, notice: 'Ttmsfile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ttmsfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ttmsfiles/1
  # DELETE /ttmsfiles/1.json
  def destroy
    @ttmsfile = Ttmsfile.find(params[:id])
    @ttmsfile.destroy

    respond_to do |format|
      format.html { redirect_to ttmsfiles_url }
      format.json { head :no_content }
    end
  end
end
