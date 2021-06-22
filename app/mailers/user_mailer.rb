class UserMailer < ApplicationMailer
  def buyer_account_created
    @email = params[:email]

    mail(
      from: 'Stock App <support@gmail.com>',
      to: @email,
      subject: 'Your account has been successfully created.'
    )
  end

  def pending_approval_email
    @email = params[:email]

    mail(
      from: 'Stock App <support@gmail.com>',
      to: @email,
      subject: "Pending Admin approval for #{@email}."
    )
  end

  def admin_approved_email
    @email = params[:email]

    mail(
      from: 'Stock App <support@gmail.com>',
      to: @email,
      subject: "Account #{@email} has been approved."
    )
  end
end
