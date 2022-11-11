class Nft < ApplicationRecord
  # TODO: add "status" field, values "minted", "sold" ?

  has_many :tags, class_name: 'NftTag', foreign_key: :fingerprint, dependent: :destroy
  has_many :likes, class_name: 'NftLike', foreign_key: :fingerprint, dependent: :destroy
  has_many :endorsers, class_name: 'NftEndorser', foreign_key: :fingerprint, dependent: :destroy
  belongs_to :user, foreign_key: 'owner_id'
  belongs_to :cardano_address, optional: true

  validates :fingerprint, presence: true, uniqueness: true
  validates :policy_id, :asset_name, presence: true

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
      transitions from: :minting_accepted, to: :minted
    end

    event :mint_failed, after: :mint_failed_notification do
      transitions from: :minting_accepted, to: :mint_failed
    end

    event :sell_init, after: :sell_init_notification do
      transitions from: :minted, to: :on_sale
    end

    event :sell_success, after: :sell_success_notification do
      transitions from: :on_sale, to: :minted
    end
  end

  def active_model_serializer
    NftSerializer
  end

  def send_to_minting
    url = 'http://127.0.0.1:5000/api/v1/nfts'
    json = create_json_for_request
    puts json
    headers = { 'Content-Type' => 'application/json' }
    HTTParty.post(url, body: json, headers: headers)
  end

  private

  def create_json_for_request
    JSON.generate(
      {
        nft_id: self.nft_id,
        nft_name: self.name,
        nft_long_name: self.asset_name,
        nft_description: self.description,
        nft_image_ipfs: self.url
      }
    )
  end

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

  def sell_init_notification
    NotificationMailer.with(nft: self).new_sell_init.deliver_later
  end

  def sell_success_notification
    NotificationMailer.with(nft: self).sell_success.deliver_later
  end
end
