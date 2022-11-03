class NotificationMailer < ApplicationMailer
  default from: 'no-reply@intellart.com'

  def request_for_minting
    @nft = params[:nft]
    @user = User.find_by_id(@nft.owner_id)
    @email = Admin.all.pluck(:email)
    mail(to: @email, subject: 'New request for minting!')
  end

  def minting_accepted
    @nft = params[:nft]
    @user = User.find_by_id(@nft.owner_id)
    @email = @user.email
    mail(to: @email, subject: 'Your minting request has been accepted!')
  end

  def minting_rejected
    @nft = params[:nft]
    @user = User.find_by_id(@nft.owner_id)
    @email = @user.email
    mail(to: @email, subject: 'Your minting request has been rejected!')
  end

  def mint_success
    @nft = params[:nft]
    @user = User.find_by_id(@nft.owner_id)
    @email = ([@user.email] << Admin.all.pluck(:email)).flatten
    mail(to: @email, subject: 'NFT Minting successful!')
  end

  def mint_failed
    @nft = params[:nft]
    @user = User.find_by_id(@nft.owner_id)
    @email = ([@user.email] << Admin.all.pluck(:email)).flatten
    mail(to: @email, subject: 'NFT Minting failed!')
  end

  def new_sell_request
    @nft = params[:nft]
    @user = User.find_by_id(@nft.owner_id)
    @email = Admin.all.pluck(:email)
    mail(to: @email, subject: 'New request for sell!')
  end

  def selling_accepted
    @nft = params[:nft]
    @user = User.find_by_id(@nft.owner_id)
    @email = @user.email
    mail(to: @email, subject: 'Your sell request has been accepted!')
  end

  def selling_rejected
    @nft = params[:nft]
    @user = User.find_by_id(@nft.owner_id)
    @email = @user.email
    mail(to: @email, subject: 'Your sell request has been rejected!')
  end

  def sell_success
    @nft = params[:nft]
    @user = User.find_by_id(@nft.owner_id)
    @email = @user.email
    mail(to: @email, subject: 'Your NFT has been successfuly sold!')
  end
end
