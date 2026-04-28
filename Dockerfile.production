ARG RUBY_VERSION=4.0.1
FROM docker.io/library/ruby:$RUBY_VERSION-slim

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y curl libjemalloc2 libvips postgresql-client build-essential git libpq-dev libyaml-dev pkg-config fontconfig zlib1g-dev && \
    ln -s /usr/lib/$(uname -m)-linux-gnu/libjemalloc.so.2 /usr/local/lib/libjemalloc.so && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

ENV DEBIAN_FRONTEND=noninteractive \
    RAILS_ENV="production" \ 
    BUNDLE_DEPLOYMENT="1" \ 
    BUNDLE_PATH="/usr/local/bundle" \ 
    BUNDLE_WITHOUT="development" \
    RUBY_RESERVED_FD_ENABLE=0 \
    LD_PRELOAD="/usr/local/lib/libjemalloc.so"

# Rails app lives here
WORKDIR /rails

COPY vendor/* ./vendor/
COPY Gemfile Gemfile.lock ./
RUN bundle install && rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && bundle exec bootsnap precompile -j 1 --gemfile

COPY . .
RUN rm config/database.yml
COPY config/database.cloudrun.yml config/database.yml
RUN bundle exec bootsnap precompile -j 1 app/ lib/
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

RUN groupadd --system --gid 1000 rails && useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && chown -R rails:rails db log vendor storage tmp entrypoint.sh falcon.rb && chmod +x entrypoint.sh && chmod +x falcon.rb
USER 1000:1000

EXPOSE 8080
ENTRYPOINT ["./entrypoint.sh"]

