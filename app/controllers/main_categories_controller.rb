class MainCategoriesController < ApplicationController
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
    },
    {
      "id": 4,
      "description": "Almoço ( ifood )",
      "category": "Alimentação",
      "value": 60,
      "date": "2022-11-01"
    },
    {
      "id": 5,
      "description": "Festa com os amigos",
      "category": "Lazer",
      "value": 300,
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
    if params[:type].present?
      render json: type.group_by {|item| item[:category] }
                                    .collect {|key, value| {"Category": key, "Total": value.sum {|v| v[:value].to_f} } }
    else
      render json: {"message": "Por favor forneça um tipo válido ( expense or financial_received )."}
    end
  end

  private

  def type
    params[:type] === "expense" ? EXPENSE_DATA : FINANCIAL_RECEIVED_DATA
  end
end
