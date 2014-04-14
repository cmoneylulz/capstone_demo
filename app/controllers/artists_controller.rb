class ArtistsController < ApplicationController
	
	# Set the models used for each action and authorize the current user
	load_and_authorize_resource except: :show
	
  # GET /artists
  # GET /artists.json
  def index
  end

  # GET /artists/1
  # GET /artists/1.json
  def show
  	@artist = Artist.find(params[:id])
    @artist_interest_points = InterestPoint.joins(:artist_interest_points).where('artist_interest_points.artist_id = ?', @artist.id).uniq
  end

  # GET /artists/new
  def new
  end

  # GET /artists/1/edit
  def edit
  end

  # POST /artists
  # POST /artists.json
  def create
    @artist = Artist.new(artist_params)
    respond_to do |format|
      if @artist.save
        format.html { redirect_to @artist, flash[:notice] = 'Artist was successfully created.' }
        format.json { render action: 'show', status: :created, location: @artist }
      else
        format.html { render action: 'new' }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artists/1
  # PATCH/PUT /artists/1.json
  def update
    respond_to do |format|
      if @artist.update(artist_params)
        format.html { redirect_to @artist, flash[:notice] = 'Artist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.json
  def destroy
    @artist.destroy
    respond_to do |format|
      format.html { redirect_to artists_url }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def artist_params
      params.require(:artist).permit(:first_name, :last_name)
    end
end
