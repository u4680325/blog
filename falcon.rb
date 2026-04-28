#!/usr/bin/env -S falcon-host
# frozen_string_literal: true

require "falcon/environment/rack"

hostname = File.basename(__dir__)

service hostname do
  include Falcon::Environment::Rack
  preload "falcon_preload.rb"
  count ENV.fetch("WEB_CONCURRENCY", 1).to_i
  port { ENV.fetch("PORT", 8080).to_i }
  endpoint do
    Async::HTTP::Endpoint
      .parse("h2c://0.0.0.0:#{port}")
      .with(protocol: Async::HTTP::Protocol::HTTP2)
  end
end
