class QuestionsController < ApplicationController
    # `before_action` is a lifecycle method for controllers.
    # It will call method given as a symbol before any action in the
    # controller is executed.
    # With the `only` named parameter, we can tell it to ignore
    # certain actions.
    # https://api.rubyonrails.org/classes/AbstractController/Callbacks/ClassMethods.html#method-i-before_action
    before_action :find_question, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:show, :index]
    before_action :authorize_user!, only: [:edit, :update, :destroy]
  
    def new
      # Always use your model exclusive in your controllers.
      # Pass their values to your views with instance variables.
      @question = Question.new
    end
  
    def create
      @question = Question.new question_params
      @question.user = current_user
      
      if @question.save
        redirect_to question_path(@question.id)
      else
        render :new
      end
    end
  
    def index
      @questions = Question.order(created_at: :desc)
    end
  
    def show
      @answers = @question.answers.order(created_at: :desc)
      @answer = Answer.new
      # @question.view_count += 1
      # Use `update_columns` sparingly. It's alternative to `update`
      # that skips: validation, lifecycle callbacks, update_at update is skipped
      @question.update_columns(view_count: @question.view_count + 1)
    end
  
    def destroy
      @question.destroy
      
      redirect_to questions_path
    end
    
    def edit
    end
  
    def update
  
      if @question.update question_params
        redirect_to question_path(@question.id)
      else
        render :edit
      end
    end
  
    private
    def find_question
      @question = Question.find params[:id]
    end
  
    def question_params
      params.require(:question).permit(:title, :body)
    end

    def authorize_user!
      unless can?(:crud, @question)
        flash[:danger] = "Access Denied"
        redirect_to root_path
      end
    end
  end