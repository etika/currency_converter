require 'net/http'
require 'json'
require 'money'

class ConverterController < ApplicationController
  def convert_currency

  	final_hash={}
   	start_year, end_year, currency_first, currency_second= params[:start_year], params[:end_year],params[:currency_first], params[:currency_second]
    symbols= params[:currency_first].upcase+","+params[:currency_second].upcase
    # url =  "https://api.exchangeratesapi.io/history?start_at=#{start_year}&end_at=#{end_year}&symbols=#{symbols}"
    url="https://api.exchangeratesapi.io/history?start_at=2018-01-01&end_at=2018-09-01&symbols=ILS,JPY"
    puts "LOLLLL", url
    uri = URI(url)
    response = Net::HTTP.get(uri)
    response_obj = JSON.parse(response)
    @currency_first_array, @currency_second_array=[],[]
    # @currency_first_array << "data1"
    response_obj["rates"].each do |key, value|
      puts "oooooooo", key
      puts "loll", value[currency_first.upcase]
      f_currency = value[currency_first.upcase] if value[currency_first.upcase].present?
      s_currency = value[currency_second.upcase] if value[currency_second.upcase].present?
      @currency_first_array << f_currency
      @currency_second_array << s_currency
      @currency_first_array= @currency_first_array.first(7)
      puts ".....", @currency_first_array
      final_hash[key]= currency_first.upcase.to_s+"="+f_currency.to_s + "and" +currency_second.upcase.to_s+"="+ s_currency.to_s
    end
     # render json: {message: final_hash,:status => 204}

  end

  def show_currency_converter
    @currencies = all_currencies(Money::Currency.table)
  end

  def all_currencies(hash)
    hash.keys
  end
end
