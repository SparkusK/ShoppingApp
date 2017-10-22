config.redis_host = URI.parse(ENV["REDISTOGO_URL"]).host
config.redis_port = URI.parse(ENV["REDISTOGO_URL"]).port
config.redis_password = URI.parse(ENV["REDISTOGO_URL"]).password
