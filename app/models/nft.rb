class Nft < ApplicationRecord
  has_many :tags, class_name: 'NftTag', foreign_key: :fingerprint, dependent: :destroy
  has_many :likes, class_name: 'NftLike', foreign_key: :fingerprint, dependent: :destroy
  has_many :endorsers, class_name: 'NftEndorser', foreign_key: :fingerprint, dependent: :destroy
  belongs_to :user, foreign_key: 'owner_id'

  validates :fingerprint, presence: true, uniqueness: true
  validates :policy_id, presence: true

  after_create :new_nft_broadcast

  has_one_attached :file

  include AASM
  aasm column: :state do
    state :request_for_minting, initial: true
    state :minting_accepted
    state :minted
    state :mint_failed
    state :minting_rejected
    state :on_sale

    event :accept_minting, after: :minting_accepted_notification do
      transitions from: :request_for_minting, to: :minting_accepted
    end

    event :reject_minting, after: :minting_rejected_notification do
      transitions from: :request_for_minting, to: :minting_rejected
    end

    event :mint_success, after: :mint_success_notification do
      transitions from: [:minting_accepted, :mint_failed], to: :minted
    end

    event :mint_failed, after: :mint_failed_notification do
      transitions from: [:minting_accepted, :mint_failed], to: :mint_failed
    end

    event :sell_success, after: :sell_success_notification do
      transitions from: :minted, to: :on_sale
    end

    event :buy_success, after: :buy_success_notification do
      transitions from: :on_sale, to: :minted
    end
  end

  def active_model_serializer
    NftSerializer
  end

  def send_to_minting
    url = 'http://127.0.0.1:5000/api/v1/nfts/submit_tx'
    json = { tx: self.tx_id, witness: self.witness }
    headers = { 'Content-Type' => 'application/json' }
    HTTParty.post(url, body: json.to_json, headers: headers)
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

  def sell_success_notification
    NotificationMailer.with(nft: self).sell_success.deliver_later
  end

  def buy_success_notification
    NotificationMailer.with(nft: self).buy_success.deliver_later
  end
end
