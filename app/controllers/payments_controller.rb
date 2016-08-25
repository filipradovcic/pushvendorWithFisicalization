class PaymentsController < ApplicationController
  def make_payment
    @sale = Sale.find(params[:payments][:sale_id])
    Payment.create(payment_type: params[:payments][:payment_type],
                   amount: params[:payments][:amount],
                   sale_id: params[:payments][:sale_id])


    if(params[:payments][:payment_type]== 'credit_card')
       logger.info('redirect user to internet payment gateway')
       fiscalizer = Fiscalizer.new
       logger.info(fake_ipg_authorization)
    elsif(params[:payments][:payment_type]== 'cash')
       logger.info('fisiclize invoice')
       fiscalizer = Fiscalizer.new
    else
      logger.info('wait for the back office to clear the payment')
    end







    respond_to do |format|
      format.js
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:payment_type, :amount, :sale_id)
  end


  def fake_ipg_authorization

    return Random.new.rand(100000..999999)
  end
end