class BillsController < ApplicationController
  # GET /bills
  def index
    @bills = Bill.all.reverse
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
        format.html { render action: "new" }
      end
    end
  end

  # GET /bills/:id
  def show
    @bill = Bill.find(params[:id])

    @totals = summarize_calls(@bill.calls.group('source'))
    @totals.merge!({ 'TOTAL' => summarize_calls(@bill.calls).values.first })
  end

  def summarize_calls(calls)
    calls.select("
      source,
      count(*) as count,
      sum(duration) as duration,
      sum(cost) as cost,
      avg(duration) as avg_duration,
      avg(cost) as avg_cost").
      inject({}) { |r, totals|
        r[totals.source] = totals.attributes
        r
      }
  end
end
