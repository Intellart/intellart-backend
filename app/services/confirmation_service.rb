class ConfirmationService
  # TODO: write logic for checking if an NFT has been minted/sold

  # do we put periodic checking here or on jobs queue?

  def check_mint_success
    # query blockfrost for an asset
    # if response:
      # asset exists, call mint_success
    # else:
      # asset has not been minted, call mint_failed | try again after some time? try again how many times?
  end

  def check_sell_success
    # query address for a specific asset
    # if response:
      # asset not sold yet, do nothing and return | try again after some time? try again how many times?
    # else:
      # asset has been sold, call sell_success
  end
end
