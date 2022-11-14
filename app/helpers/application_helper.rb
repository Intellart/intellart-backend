module ApplicationHelper
  def str_to_hex(str)
    str.each_byte.map { |b| b.to_s(16) }.join
  end

  def make_hex_asset(nft)
    # TODO: asset name needs to be in hex
    nft.policy_id + str_to_hex(nft.asset_name)
  end
end
