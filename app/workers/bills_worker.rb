class BillsWorker
  include Sidekiq::Worker

  def perform(bill_id)
    bill = Bill.find(bill_id)
    bill.process_csv if bill.csv.present?
    bill.save
  end
end
