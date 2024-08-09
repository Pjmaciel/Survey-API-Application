class SurveysController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_survey, only: [:update, :destroy]

  def create
    @survey = current_user.surveys.build(survey_params)
    authorize @survey  # Verifica se o usuário tem permissão para criar a pesquisa

    if @survey.save
      render json: @survey, status: :created
    else
      render json: @survey.errors, status: :unprocessable_entity
    end
  end

  def update
    @survey = Survey.find(params[:id])
    authorize @survey  # Verifica se o usuário tem permissão para atualizar a pesquisa

    if @survey.update(survey_params)
      render json: @survey, status: :ok
    else
      render json: @survey.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @survey = Survey.find(params[:id])
    authorize @survey  # Verifica se o usuário tem permissão para deletar a pesquisa
    @survey.destroy
    head :no_content
  end

  private

  def survey_params
    params.require(:survey).permit(:title, :status)
  end

  def authorize_survey
    authorize @survey
  end
end
