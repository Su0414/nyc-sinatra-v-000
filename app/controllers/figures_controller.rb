class FiguresController < ApplicationController

  get '/figures/new' do
    erb :'/figures/new'
  end

  post '/figures' do
    @figure = Figure.create(name: params["figure_name"])
    if params["new_title"] == ""
          @figure.titles << Title.find_by_id(params[:figure][:title_ids])
      else
          @figure.titles << Title.create(name: params["new_title"])
    end
    # binding.pry
      if params[:landmark][:name] == ""
      else
        @figure.landmarks << Landmark.find_or_create_by(params[:landmark])
      end
      if params[:figure][:landmark_ids] == ""
      else
        @figure.landmarks << Landmark.find_by_id(params[:figure][:landmark_ids])
     end

    @figure.save
    redirect "/figures/#{@figure.id}"

  end

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end



  get "/figures/:id/edit" do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/edit'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/show'
  end


  post '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    
     @figure.name = params["figure_name"]
     
     if params["new_title"] != ""
       @figure.titles << Title.find_or_create_by(name: params["new_title"])
     end

     if params[:landmark] != nil
      @figure.landmarks << Landmark.find_or_create_by(params[:landmark])
    else
      if params["new_landmark"] != ""
        @figure.landmarks << Landmark.create(params[:landmark])
      end
    end

     if params[:figure][:landmark_ids] != nil
       @figure.landmarks << Landmark.find_by_id(params[:figure][:landmark_ids])
     end

     @figure.save
     redirect "/figures/#{@figure.id}"
  end

end
