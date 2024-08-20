class SurveysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_survey, only: [:show, :update, :destroy]
  before_action :authorize_survey, only: [:update, :destroy]

  # GET /surveys
  def index
    @surveys = current_user.surveys
    render json: @surveys, status: :ok
  end

  # GET /surveys/:id
  def show
    render json: @survey, status: :ok
  end

  # POST /surveys
  def create
    @survey = current_user.surveys.build(survey_params)
    authorize @survey

    if @survey.save
      render json: @survey, status: :created
    else
      render json: { errors: @survey.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /surveys/:id
  def update
    if @survey.update(survey_params)
      render json: @survey, status: :ok
    else
      render json: { errors: @survey.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /surveys/:id
  def destroy
    @survey.destroy
    head :no_content
  end

  private

  # Carrega a pesquisa a partir do ID fornecido
  def set_survey
    @survey = Survey.find(params[:id])
  end


  def survey_params
    params.require(:survey).permit(:title, :status, questions_attributes: [:id, :question_text, :question_type, :_destroy, options_attributes: [:id, :option_text, :_destroy]])
  end


  def authorize_survey
    authorize @survey
  end
end
