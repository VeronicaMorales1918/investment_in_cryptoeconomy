require 'httparty'

# This class queries the exchange rate by currency
class CoinApiService
  def initialize; end

  def get_exchange_rate(currency)
    response_coinapi(currency)
  end

  private

  def response_coinapi(currency)
    response = HTTParty.get(url_coinapi(currency), headers: headers)

    response['rate'] || 0.0
  end

  def headers
    @headers ||= { 'X-CoinAPI-Key' => api_key }
  end

  def url_coinapi(currency)
    "https://rest.coinapi.io/v1/exchangerate/#{currency}/USD"
  end

  def api_key
    '36CE47B0-F34B-45B3-8B18-1B5C170D3248'
  end
end
