class ConfirmMailer < ApplicationMailer
    def send_mail picture
        @picture = picture
        mail(
          from: ENV["MAIL_ADDRESS"],
          to:   @picture.user.email,
          subject: @picture.title + 'を投稿しました'
        )
      end
end
