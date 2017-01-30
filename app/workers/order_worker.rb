class OrderWorker
  include Sidekiq::Worker

  def perform(order_id)
    order = Order.find(order_id)
    order.update(status: :completed)
  end
end
