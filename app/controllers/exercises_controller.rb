class ExercisesController < ApplicationController
   def index
       
   end
   
   def new
      @excerise = current_user.exercises.new  
   end
end