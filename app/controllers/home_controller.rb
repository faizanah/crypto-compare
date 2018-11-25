class HomeController < ApplicationController
  def index
    @currencies = []
    data.each do |row|
      @currencies.push([row['time_close'].to_datetime.to_i * 1000, row['price_open'],row['price_high'], row['price_low'], row['price_close']])
    end
    puts @currencies
  end

  def data
    # Sample Response Data from coin API
    # {
    #   "time_period_start": "2018-11-12T00:00:00.0000000Z",
    #   "time_period_end": "2018-11-13T00:00:00.0000000Z",
    #   "time_open": "2018-11-12T00:00:08.0000000Z",
    #   "time_close": "2018-11-12T23:59:50.0000000Z",
    #   "price_open": 6352.57,
    #   "price_high": 6388.21,
    #   "price_low": 6298.5,
    #   "price_close": 6318,
    #   "volume_traded": 3526.039032383,
    #   "trades_count": 9037
    # }
    coinApi = ENV['COIN_API'] || 'B1ECA4B0-D090-4407-AD8C-87948349F44F' # Place Your ApiKey Here
    url = "https://rest.coinapi.io/v1/ohlcv/BITSTAMP_SPOT_BTC_USD/latest?period_id=1DAY&limit=100&&apikey=#{coinApi}"
    response = HTTParty.get url
    JSON.parse response.body
 end
end
