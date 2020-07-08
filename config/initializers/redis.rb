REDIS_CONFIG = YAML.load_file("#{Rails.root}/config/redis.yml")[Rails.env]
$redis = Redis.new(url: REDIS_CONFIG['url'])