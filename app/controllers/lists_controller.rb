class ListsController < ApplicationController
  def index
    @lists = List.all   # shows all lists
  end

  def show
    @list = List.find(params[:id]) # finds id of a single list
  end

  def new
    @list = List.new # initialize the list model
  end

  def create
    @list = List.new(list_params) #generates a new list object with the parameters returned from the list_params method.
    if @list.save
      flash[:notice] = "List successfully added!"
      redirect_to lists_path # redirecting to /lists
    else
      render :new
    end
  end

  def edit
    @list = List.find(params[:id]) #we do NOT need to use strong parameters. We can safely pull the id from the params.
  end

  def update
    @list= List.find(params[:id])
    if @list.update(list_params)
      flash[:notice] = "List successfully updated!"
      redirect_to lists_path
    else
      render :edit
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    flash[:notice] = "List successfully deleted!"
    redirect_to lists_path
  end

# needed for create and update - needs to be on bottom
  private #Strong parameters use a private method to permit only designated parameters to be passed for our model. Therefore, any malicious request sent with malicious parameters will not successfully process since the private method can not be accessed.
    def list_params
      params.require(:list).permit(:name, :author, :description) #example of multiple fields
    end




end
