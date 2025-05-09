class Api::V1::ReportsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  def index
    user = User.find(params[:user_id])
    reports = user.reports
    render json: reports
  end

  def show
    report = Report.find(params[:id])
    render json: ReportsSerializer.format_report_data(report)
  end

  def create
    report = Report.new(report_params.except(:user_id))
    if !Report.is_unique_nickname?(params[:nickname], params[:user_id])
      render json: { status: 422, message: "Nickname must be unique." }, status: :unprocessable_entity
      return
    end
    
    if report.save
      UserReport.create!(user_id: report_params[:user_id], report_id: report.id)
      render json: report, status: :created
    else
      render json: { errors: report.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # def energy_usage
  #   usage_data = {
  #     location: params[:location],
  #     type: params[:type],
  #     occupants: params[:occupants],
  #     energy_usage: params[:energy_usage]
  #   }
  #
  #   render json: usage_data
  # end

  private

def report_params
  params.permit(
    :user_id,
    :nickname,
    :energy_consumption,
    :energy_cost,
    :state,
    :state_residential_avg,
    :state_industrial_avg,
    :state_commercial_avg,
    :zip_residential_avg,
    :zip_industrial_avg,
    :zip_commercial_avg
  )
end
  def record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def record_invalid(exception)
    render json: { error: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end

