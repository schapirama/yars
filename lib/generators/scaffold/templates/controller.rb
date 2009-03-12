class <%= controller_class_name %>Controller < ApplicationController
  
  def index
    @<%= table_name %> = <%= class_name %>.paginate :page => params[:page]
  end

  def new
    @<%= file_name %> = <%= class_name %>.new(params[:<%= file_name %>])
    if request.post?
      if @<%= file_name %>.save
        return redirect_to(:action => :index)
      end
    end
    render :action => :edit
  end

  def edit
    @<%= file_name %> = <%= class_name %>.find(params[:id])
    if request.put?
      if @<%= file_name %>.update_attributes(params[:<%= file_name %>])
        return redirect_to(:action => :index)
      end
    end
  end

  def destroy
    @<%= file_name %> = <%= class_name %>.find(params[:id])
    @<%= file_name %>.destroy
    redirect_to :action => :index
  end

end