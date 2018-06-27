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
    binding.pry
      if params[:landmark][:name] != ""
        @figure.landmarks << Landmark.find_or_create_by(params[:landmark])
      elsif  params[:figure][:landmark_ids] != ""
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
      @figure.landmarks << Landmark.create(name: params[:landmark][:name] , year_completed:params[:landmark][:year_completed])
    else
      if params["new_landmark"] != ""
        @figure.landmarks << Landmark.create(name: params["new_landmark"] , year_completed:params["new_landmark_year_completed"])
      end
    end

     if params[:figure][:landmark_ids] != nil
       @figure.landmarks << Landmark.find_by_id(params[:figure][:landmark_ids])
     end

     @figure.save
     redirect "/figures/#{@figure.id}"
  end

end
