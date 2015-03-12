class PupsController < ApplicationController
  
  def index
    @pups = Pup.all
  end

  def new
    @all_breeds = Pup.all_breeds
    @all_breeds_none = Pup.all_breeds_none
  end

  def main
    @all_breeds = Pup.all_breeds
    @all_breeds_none = Pup.all_breeds_none
    @all_breeders = Breeder.all.map {|breeder| breeder.name}
  end

  def show
    @pup = Pup.find params[:id]
  end

  def create
    @pup = Pup.new(params[:pup])
    if @pup.save
      flash[:notice] = "#{@pup.pup_name} was successfully added"
      redirect_to pups_path
    else 
      flash.keep[:notice] = "Please make sure all fields are complete!"
      redirect_to new_pup_path
    end
  end

  def breed
    pup_breeds = params[:pup]
    @pups = Pup.find_by_breeds(pup_breeds[:breed_1], pup_breeds[:breed_2])
    if @pups.length == 0
      flash[:message] = "Sorry, there are no dogs of the breed #{pup_breeds[:breed_1]}"
      flash[:message] += " and #{pup_breeds[:breed_2]}" if pup_breeds[:breed_2] != 'None'
      redirect_to root_path and return
    end
    @avg_ratings = Pup.avg_ratings_by_breeds(pup_breeds[:breed_1], pup_breeds[:breed_2])
  end

  def update
    @pup = Pup.find params[:id]
    @pup.update_attributes(params[:pup])
    redirect_to pups_path
  end

  def destroy
    @pup = Pup.find params[:id]
    @pup.destroy
    redirect_to pups_path
  end

end
