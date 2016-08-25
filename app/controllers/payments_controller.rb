class PaymentsController < ApplicationController
  def make_payment
    @sale = Sale.find(params[:payments][:sale_id])
    Payment.create(payment_type: params[:payments][:payment_type],
                   amount: params[:payments][:amount],
                   sale_id: params[:payments][:sale_id])


    if(params[:payments][:payment_type]== 'credit_card')
       logger.info('redirect user to internet payment gateway')
    elsif(params[:payments][:payment_type]== 'cash')
       logger.info('fisiclize invoice')
    else
      logger.info('wait for the back office to clear the payment')
    end


    fiscalizer = Fiscalizer.new

    logger.info('Fizicaling invoice')


    respond_to do |format|
      format.js
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:payment_type, :amount, :sale_id)
  end
end