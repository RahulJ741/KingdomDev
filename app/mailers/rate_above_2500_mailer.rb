class RateAbove2500Mailer < ApplicationMailer
	default from: 'rahul.j@infiny.in'
  def rate_exteted(user)
    mail to: => user.email, :subject => "Your payment exteded"
    # mail to: => "", :subject => "Payment exteded of user"
  end
end
