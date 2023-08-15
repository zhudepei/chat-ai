FROM ruby:3.2.2

ENV LANG=C.UTF-8
ENV BUNDLE_JOBS=4
ENV BUNDLE_RETRY=3

RUN sed -i 's#http://deb.debian.org#https://mirrors.163.com#g' /etc/apt/sources.list
RUN  apt update && apt install -y --no-install-recommends \
     build-essential \
     cron \
     curl \
     git  \
     tzdata \
     ffmpeg \
     default-libmysqlclient-dev \
     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN bundle config mirror.https://rubygems.org https://gems.ruby-china.com
RUN gem update --system && gem install bundler

WORKDIR /app
COPY Gemfile* .
RUN RAILS_ENV=production bundle install

COPY . .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["entrypoint.sh"]


