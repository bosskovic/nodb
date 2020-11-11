FROM ruby:2.7.2 as builder

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential nodejs yarn

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN gem install bundler:2.1.2
ADD Gemfile* $APP_HOME/
RUN bundle config set without 'development test'
RUN bundle install

ADD . $APP_HOME
RUN yarn install --check-files
CMD ["rails","server","-b","0.0.0.0"]
ENV SECRET_KEY_BASE dab63fd1eb36aace74661f1bab7db8ae06fc0be95379b5165538b998a5a8da84dc72c8937c50c07147e8768bede658501674ad9453d57aaf864d80ae29de400f
RUN RAILS_ENV=production SECRET_KEY_BASE=$SECRET_KEY_BASE bundle exec rake assets:precompile