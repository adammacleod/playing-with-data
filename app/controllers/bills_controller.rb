class BillsController < ApplicationController
  # GET /bills
  def index
    @bills = Bill.all
  end

  # GET /bills/new
  def new
    @bill = Bill.new
  end

  # POST /bills
  def create
    @bill = Bill.new(params[:bill])

    respond_to do |format|
      if @bill.save
        format.html { redirect_to @bill }
      else
        format.html { format.html { render action: "new" } }
      end
    end
  end

  # GET /bills/:id
  def show
    @bill = Bill.find(params[:id])
  end
end
