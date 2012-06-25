#encoding: utf-8
class UserMailer < ActionMailer::Base
  default :from => "weboldal@ewutazas.hu"

  def travel_order(order_id)
    email = '0antalbalazs0@gmail.com'
    @order = Order.find(order_id)
    # @travel_time = @order.travel_time
    # @travel_offer = @travel_time.travel_offer
    mail(:to => email, :subject => "Megrendelés a weboldalról")
  end

  def travel_order_thankyou(order_id)
    @order = Order.find(order_id)
    # @travel_time = @order.travel_time
    # @travel_offer = @travel_time.travel_offer
    mail(:to => @order.email, :subject => "Megrendelés a weboldalról")
  end
end
