class AnswersController < ApplicationController
    before_action :find_answer, only: [:edit, :destroy, :update]
    before_action :authenticate_user!
    before_action :authorize_user!, except: [:create]

    def create
        @question = Question.find params[:question_id]
        @answer = Answer.new answer_params
        @answer.question = @question
        @answer.user = current_user


        if @answer.save
            redirect_to question_path(@question)
        else
            @answers = @question.answers.order(created_at: :desc)
            render "questions/show"
        end
    end

    def edit
    end

    def destroy
        @answer.destroy
        redirect_to question_path(@answer.question)
    end

    def update
        if @answer.update answer_params
            redirect_to question_path(@answer.question)
        else
            render :edit
        end
    end

    private
    def answer_params
        params.require(:answer).permit(:body)
    end

    def find_answer
        @answer = Answer.find params[:id]
    end

    def authorize_user!
        unless can?(:crud, @answer)
          flash[:danger] = "Access Denied"
          redirect_to root_path
        end
    end
end

