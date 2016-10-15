class ZakazisController < ApplicationController
  # GET /zakazis
  # GET /zakazis.json
  def index
    @zakazis = Zakazi.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @zakazis }
    end
  end

  # GET /zakazis/1
  # GET /zakazis/1.json
  def show
    @zakazi = Zakazi.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @zakazi }
    end
  end

  # GET /zakazis/new
  # GET /zakazis/new.json
  def new
    @zakazi = Zakazi.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @zakazi }
    end
  end

  # GET /zakazis/1/edit
  def edit
    @zakazi = Zakazi.find(params[:id])
  end

  # POST /zakazis
  # POST /zakazis.json
  def create
    @zakazi = Zakazi.new(params[:zakazi])

    respond_to do |format|
      if @zakazi.save
        format.html { redirect_to @zakazi, notice: 'Zakazi was successfully created.' }
        format.json { render json: @zakazi, status: :created, location: @zakazi }
      else
        format.html { render action: "new" }
        format.json { render json: @zakazi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /zakazis/1
  # PUT /zakazis/1.json
  def update
    @zakazi = Zakazi.find(params[:id])

    respond_to do |format|
      if @zakazi.update_attributes(params[:zakazi])
        format.html { redirect_to @zakazi, notice: 'Zakazi was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @zakazi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /zakazis/1
  # DELETE /zakazis/1.json
  def destroy
    @zakazi = Zakazi.find(params[:id])
    @zakazi.destroy

    respond_to do |format|
      format.html { redirect_to zakazis_url }
      format.json { head :no_content }
    end
  end
end
