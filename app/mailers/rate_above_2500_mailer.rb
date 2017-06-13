class RateAbove2500Mailer < ApplicationMailer
  def rate_exteted()
    mail to: => user.email, :subject => "Your payment exteded"
    mail to: => "", :subject => "Payment exteded of user"
  end
end
