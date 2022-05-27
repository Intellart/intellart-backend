# frozen_string_literal: true

Redis.current = Redis.new(url: ENV.fetch('REDIS_URL', 'redis://localhost'),
                          port: ENV.fetch('REDIS_PORT', 6379),
                          db: ENV.fetch('REDIS_DB', 0))