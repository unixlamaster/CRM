class TtmscommentsController < ApplicationController
  # GET /ttmscomments
  # GET /ttmscomments.json
  def index
    @ttmscomments = Ttmscomment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ttmscomments }
    end
  end

  # GET /ttmscomments/1
  # GET /ttmscomments/1.json
  def show
    @ttmscomment = Ttmscomment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ttmscomment }
    end
  end

  # GET /ttmscomments/new
  # GET /ttmscomments/new.json
  def new
    @ttmscomment = Ttmscomment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ttmscomment }
    end
  end

  # GET /ttmscomments/1/edit
  def edit
    @ttmscomment = Ttmscomment.find(params[:id])
  end

  # POST /ttmscomments
  # POST /ttmscomments.json
  def create
    @ttmscomment = Ttmscomment.new(params[:ttmscomment])

    respond_to do |format|
      if @ttmscomment.save
        format.html { redirect_to @ttmscomment, notice: 'Ttmscomment was successfully created.' }
        format.json { render json: @ttmscomment, status: :created, location: @ttmscomment }
      else
        format.html { render action: "new" }
        format.json { render json: @ttmscomment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ttmscomments/1
  # PUT /ttmscomments/1.json
  def update
    @ttmscomment = Ttmscomment.find(params[:id])

    respond_to do |format|
      if @ttmscomment.update_attributes(params[:ttmscomment])
        format.html { redirect_to @ttmscomment, notice: 'Ttmscomment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ttmscomment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ttmscomments/1
  # DELETE /ttmscomments/1.json
  def destroy
    @ttmscomment = Ttmscomment.find(params[:id])
    @ttmscomment.destroy

    respond_to do |format|
      format.html { redirect_to ttmscomments_url }
      format.json { head :no_content }
    end
  end
end
