class TotalAccountsController < ApplicationController

  EXPENSE_DATA = [
    {
      "id": 1,
      "description": "Viajem de uber",
      "category": "Transporte",
      "value": 100,
      "date": "2022-08-12"
    },
    {
      "id": 2,
      "description": "Viajem até o centro de São Paulo",
      "category": "Transporte",
      "value": 60,
      "date": "2022-10-10"
    },
    {
      "id": 3,
      "description": "Compras do mês no mercado",
      "category": "Alimentação",
      "value": 600,
      "date": "2022-11-01"
    }
  ]

  FINANCIAL_RECEIVED_DATA = [
    {
      "id": 1,
      "description": "Hora Extras",
      "category": "Receita excepcional",
      "value": 250,
      "date": "2022-08-01"
    },
    {
      "id": 2,
      "description": "Salário",
      "category": "Receita recorrente",
      "value": 2500,
      "date": "2022-11-01"
    }
  ]



  def index
    filtered_expense = EXPENSE_DATA.filter {|expense| expense[:date] >= params[:start_date] && expense[:date] <= params[:end_date]}
    financial_received_filtered = FINANCIAL_RECEIVED_DATA.filter {|financial_received| financial_received[:date] >= params[:start_date] && financial_received[:date] <= params[:end_date]}

    total_expense = filtered_expense.map{|expense| expense[:value]}.inject(0, :+)
    total_received = financial_received_filtered.map{|financial_received| financial_received[:value]}.inject(0, :+)

    balance = total_received - total_expense

    render json: {"total expense": total_expense , "total received": total_received, "balance": balance}
  end
end
