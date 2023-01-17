class NotificationMailer < ApplicationMailer
  default from: 'no-reply@intellart.com'
  before_action :set_article_and_user, only: [:publishing_requested, :publishing_accepted, :publishing_rejected]
  before_action :set_nft_and_user, except: [:publishing_requested, :publishing_accepted, :publishing_rejected]

  def request_for_minting
    @email = Admin.all.pluck(:email)
    mail(to: @email, subject: 'New request for minting!')
  end

  def minting_accepted
    @email = @user.email
    mail(to: @email, subject: 'Your minting request has been accepted!')
  end

  def minting_rejected
    @email = @user.email
    mail(to: @email, subject: 'Your minting request has been rejected!')
  end

  def mint_success
    @email = ([@user.email] << Admin.all.pluck(:email)).flatten
    mail(to: @email, subject: 'NFT Minting successful!')
  end

  def mint_failed
    @email = ([@user.email] << Admin.all.pluck(:email)).flatten
    mail(to: @email, subject: 'NFT Minting failed!')
  end

  def sell_success
    @email = @user.email
    mail(to: @email, subject: 'NFT sale has started!')
  end

  def buy_success
    @email = @user.email
    mail(to: @email, subject: 'Your NFT has been bought!')
  end

  # PUBWEAVE #
  def publishing_requested
    @email = Admin.all.pluck(:email)
    mail(to: @email, subject: 'New request for article publishing!')
  end

  def publishing_accepted
    @email = ([@user.email] << Admin.all.pluck(:email)).flatten
    puts @email
    mail(to: @email, subject: 'Article published!')
  end

  def publishing_rejected
    @email = @user.email
    mail(to: @email, subject: 'Your article publishing request has been rejected!')
  end

  private

  def set_article_and_user
    @article = params[:blog_article]
    @user = User.find_by_id(@article.user_id)
  end

  def set_nft_and_user
    @nft = params[:nft]
    @user = User.find_by_id(@nft.owner_id)
  end
end
