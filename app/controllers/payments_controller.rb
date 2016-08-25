class PaymentsController < ApplicationController
  def make_payment
    @sale = Sale.find(params[:payments][:sale_id])
    Payment.create(payment_type: params[:payments][:payment_type],
                   amount: params[:payments][:amount],
                   sale_id: params[:payments][:sale_id])


    if(params[:payments][:payment_type]== 'credit_card')
       logger.info('redirect user to internet payment gateway')
       logger.info('fisiclize invoice')
       fiscalizer = Fiscalizer.new
       logger.info(fake_ipg_authorization)
       Invoice.create(payment_type: params[:payments][:payment_type],
                      amount: params[:payments][:amount],
                      sale_id: params[:payments][:sale_id], authorization_number: fake_ipg_authorization,
                      uuid: SecureRandom.uuid,unique_identifier: SecureRandom.hex)


    elsif(params[:payments][:payment_type]== 'cash')
      #duplicate code, but in the ipg scenario, if the
      #authorization was rejected, the invoices would not be generated
      #while in the cash scenarion the invoices is always generated
       logger.info('fisiclize invoice')
       fiscalizer = Fiscalizer.new
       Invoice.create(payment_type: params[:payments][:payment_type],
                      amount: params[:payments][:amount],
                      sale_id: params[:payments][:sale_id], authorization_number: fake_ipg_authorization,
                      uuid: SecureRandom.uuid,unique_identifier: SecureRandom.hex)


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