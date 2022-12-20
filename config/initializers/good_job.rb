Rails.application.configure do
  config.good_job.preserve_job_records = true
  config.good_job.enable_cron = true
  config.good_job.cron = { get_current_exchange_rates: { cron: '0/5 * * * *', class: 'GetCurrentExchangeRatesJob'  } }
end