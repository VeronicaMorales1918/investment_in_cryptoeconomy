class InvestmentsController < ApplicationController
  def index
    annual_investments = CalculateInvestmentService.new(nil).get_annual_investments
    render :index, locals: {
      annual_investments: annual_investments,
      csv_data: ExportCsvService.generate_csv(annual_investments),
      json_data: JSON.pretty_generate(annual_investments)
    }
  end

  def calcualte_custom_investment
    annual_investments = CalculateInvestmentService.new(params[:inversment]).get_annual_investments
    render json: {
      annual_investments: CreateTbodyService.new.create_body(annual_investments),
      csv_data: ExportCsvService.generate_csv(annual_investments),
      json_data: JSON.pretty_generate(annual_investments)
    }
  end
  def export_csv
    send_data params[:csv_data], filename: 'calculo_de_inversiones.csv', type: 'text/csv'
  end

  def export_json
    send_data params[:json_data], filename: 'calculo_de_inversiones.json', type: 'application/json'
  end
end
