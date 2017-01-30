class Order < ActiveRecord::Base
  enum status: [:processing, :completed]
  after_commit :process_order, on: :create

  private

  def process_order
    OrderWorker.perform_async(self.id)
  end
end
