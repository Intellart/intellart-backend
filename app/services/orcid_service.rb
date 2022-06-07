class OrcidService
  ORCID_API_ENDPOINT = (Rails.env.development? || Rails.env.test?) ? 'sandbox.' : ''

  # ORCID OAuth API client config
  class OrcidOAuthApi
    include HTTParty
    base_uri "https://#{ORCID_API_ENDPOINT}orcid.org"
  end

  # ORCID API client config
  class OrcidApi
    include HTTParty
    base_uri "https://pub.#{ORCID_API_ENDPOINT}orcid.org/v3.0"
  end
end
