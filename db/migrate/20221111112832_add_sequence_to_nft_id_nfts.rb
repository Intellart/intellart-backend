class AddSequenceToNftIdNfts < ActiveRecord::Migration[6.1]
  def change
    execute "CREATE SEQUENCE nfts_nft_id_seq;"
    execute "ALTER TABLE nfts ALTER COLUMN nft_id SET DEFAULT nextval('nfts_nft_id_seq');"
    execute "ALTER SEQUENCE nfts_nft_id_seq OWNED BY nfts.nft_id;"
  end
end
