class BillsController < ApplicationController
  # GET /bills
  def index
    @bills = Bill.order("id DESC").all
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
        BillsWorker.perform_async(@bill.id)
        format.html { redirect_to @bill }
      else
        format.html { render action: "new" }
      end
    end
  end

  # GET /bills/:id
  def show
    @bill = Bill.find(params[:id])

    @totals = {}
    if @bill.calls.any?
      @totals = summarize_calls_by_source(@bill.calls)
      @totals.merge!({ 'TOTAL' => summarize_calls(@bill.calls) })
    end
  end

  def summarize_calls(calls)
    calls.select("
      count(*) as count,
      sum(duration) as duration,
      sum(cost) as cost,
      avg(duration) as avg_duration,
      avg(cost) as avg_cost").first.attributes
  end

  def summarize_calls_by_source(calls)
    calls.group('source').select("
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
