class TotalAccountsController < ApplicationController

  EXPENSE_DATA = RestClient.get('localhost:3001/expenses', {params: {start_date: "2022-9-20", end_date: "2022-10-28"}})
  EXPENSE_DATA = JSON.parse EXPENSE_DATA

  FINANCIAL_RECEIVED_DATA = RestClient.get('localhost:3002/entry/read', {params: {date_begin: "2022-09-20", date_end: "2022-10-28"} })
  FINANCIAL_RECEIVED_DATA = JSON.parse FINANCIAL_RECEIVED_DATA

  def index
    filtered_expense = EXPENSE_DATA.filter {|expense| expense["date"] >= params["start_date"] && expense["date"] <= params["end_date"]}
    financial_received_filtered = FINANCIAL_RECEIVED_DATA.filter {|financial_received| financial_received["date"] >= params["start_date"] && financial_received["date"] <= params["end_date"]}

    total_expense = filtered_expense.map{|expense| expense["value"].to_i}.inject(0, :+)
    total_received = financial_received_filtered.map{|financial_received| financial_received["value"].to_i}.inject(0, :+)

    balance = total_received - total_expense

    render json: {"total expense": total_expense , "total received": total_received, "balance": balance}
  end
end
