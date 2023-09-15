require 'csv'

# This class permit claculate investment
class CalculateInvestmentService
  include ActionView::Helpers::NumberHelper
  attr_reader :investment, :csv_file_path, :investment_by_currency

  def initialize(investment)
    @investment = investment
    @csv_file_path = Rails.root.join('public', 'rates', 'origen.csv')
    @investment_by_currency = []
  end

  def get_annual_investments
    get_investments
  end

  private

  def get_investments
    if File.exist?(csv_file_path)
      CSV.foreach(csv_file_path, headers: true) do |row|
        currency = currency_type[row['Moneda'].to_sym]
        monthly_interest = row['Interes_mensual']&.to_f
        initial_balance = row['balance_ini']&.to_f
        investment_by_currency.push({
                                      name: row['Moneda'],
                                      currency: currency,
                                      monthly_interest: "#{row['Interes_mensual']}%",
                                      annual_investment: calcualte_annual_investment(monthly_interest, initial_balance,
                                                                                     currency),
                                      price: number_to_currency(get_exchange_rate(currency))
                                    })
      end

      investment_by_currency
    else
      { error: 'No se cuenta con los valores para poder realizar el calculo' }
    end
  end

  def currency_type
    {
      'Bitcoin': 'BTC',
      'Ether': 'ETH',
      'Cardano': 'ADA'
    }
  end

  def calcualte_annual_investment(monthly_interest, initial_balance, currency)
    exchange_rate = get_exchange_rate(currency)
    value = investment.present? ? investment.to_f : initial_balance

    final_value = ((value * exchange_rate) * (monthly_interest / 100) * 12) - value

    number_to_currency(final_value)
  end

  def get_exchange_rate(currency)
    CoinApiService.new.get_exchange_rate(currency)
  end
end
