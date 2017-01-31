class Order < ActiveRecord::Base
  enum status: [:processing, :completed]
  after_commit :process_order, on: :create

  has_many :albums, dependent: :destroy
  has_many :results, through: :albums

  has_secure_token

  private

  def process_order
    OrderWorker.perform_async(self.id)
  end
end
