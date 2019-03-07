FROM ruby:2.5

ENV RAILS_ENV="production" \
    SECRET_KEY_BASE="your_production_key" \
    RAILS_SERVE_STATIC_FILES="yes"

WORKDIR /app
COPY . .
EXPOSE 3000

RUN apt-get update && apt-get install -y nodejs

RUN bundle install

CMD ["bundle", "exec", "rails", "server"]
