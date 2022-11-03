class Nft < ApplicationRecord
  # TODO: add "status" field, values "minted", "sold" ?

  has_many :tags, class_name: 'NftTag', foreign_key: :fingerprint, dependent: :destroy
  has_many :likes, class_name: 'NftLike', foreign_key: :fingerprint, dependent: :destroy
  has_many :endorsers, class_name: 'NftEndorser', foreign_key: :fingerprint, dependent: :destroy
  belongs_to :user, foreign_key: 'owner_id'

  validates :fingerprint, presence: true, uniqueness: true
  validates :policy_id, :asset_name, presence: true

  after_create :new_nft_broadcast

  include AASM
  aasm column: :state do
    state :request_for_minting, initial: true
    state :minting_accepted
    state :minted
    state :mint_failed
    state :minting_rejected
    state :request_for_sell
    state :on_sale
    state :selling_rejected

    event :accept_minting, after: :minting_accepted_notification do
      transitions from: :request_for_minting, to: :minting_accepted
    end

    event :reject_minting, after: :minting_rejected_notification do
      transitions from: :request_for_minting, to: :minting_rejected
    end

    event :mint_success, after: :mint_success_notification do
      transitions from: :minting_accepted, to: :minted
    end

    event :mint_failed, after: :mint_failed_notification do
      transitions from: :minting_accepted, to: :mint_failed
    end

    event :sell_request, after: :new_sell_request_notification do
      transitions from: :minted, to: :request_for_sell
    end

    event :accept_sell, after: :selling_accepted_notification do
      transitions from: :request_for_sell, to: :on_sale
    end

    event :reject_sell, after: :selling_rejected_notification do
      transitions from: :request_for_sell, to: :selling_rejected
    end

    event :sell_success, after: :sell_success_notification do
      transitions from: :on_sale, to: :minted
    end
  end

  def active_model_serializer
    NftSerializer
  end

  private

  def new_nft_broadcast
    ActionCable.server.broadcast(
      'general_channel',
      {
        type: 'nft',
        data: self
      }
    )
  end


  def request_for_minting_notification
    NotificationMailer.with(nft: self).request_for_minting.deliver_now!
  end

  def minting_accepted_notification
    NotificationMailer.with(nft: self).minting_accepted.deliver_later
  end

  def minting_rejected_notification
    NotificationMailer.with(nft: self).minting_rejected.deliver_later
  end

  def mint_success_notification
    NotificationMailer.with(nft: self).mint_success.deliver_later
  end

  def mint_failed_notification
    NotificationMailer.with(nft: self).mint_failed.deliver_later
  end

  def new_sell_request_notification
    NotificationMailer.with(nft: self).new_sell_request.deliver_later
  end

  def selling_accepted_notification
    NotificationMailer.with(nft: self).selling_accepted.deliver_later
  end

  def selling_rejected_notification
    NotificationMailer.with(nft: self).selling_rejected.deliver_later
  end

  def sell_success_notification
    NotificationMailer.with(nft: self).sell_success.deliver_later
  end
end
