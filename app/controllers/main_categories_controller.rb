class MainCategoriesController < ApplicationController
  EXPENSE_DATA = RestClient.get('localhost:3001/expenses', {params: {start_date: "2022-9-20", end_date: "2022-10-28"}})
  EXPENSE_DATA = JSON.parse EXPENSE_DATA

  def index
    if params[:type].present?
      render json: type.group_by {|item| item["category"] }
                                    .collect {|key, value| {"Category": key, "Total": value.sum {|v| v["value"].to_f} } }
    else
      render json: {"message": "Por favor forneça um tipo válido ( expense or financial_received )."}
    end
  end

  private

  def type
    params[:type] === "expense" ? EXPENSE_DATA : FINANCIAL_RECEIVED_DATA
  end
end
