FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y libappindicator1 fonts-liberation curl \
  libasound2 libgconf2-4 libnspr4 libxss1 libnss3 xdg-utils wget unzip

RUN curl -O https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb
RUN curl -O https://chromedriver.storage.googleapis.com/2.30/chromedriver_linux64.zip && \
  unzip chromedriver_linux64.zip && \
  chmod +x chromedriver && \
  mv -f chromedriver /usr/local/share/chromedriver && \
  ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver && \
  ln -s /usr/local/share/chromedriver /usr/bin/chromedriver

RUN curl https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip -O && \
  unzip NotoSansCJKjp-hinted.zip && \
  mkdir -p /usr/share/fonts/noto && \
  cp *.otf /usr/share/fonts/noto && \
  chmod 644 -R /usr/share/fonts/noto/ && \
  fc-cache -fv

RUN apt-get install -y ruby ruby-bundler ruby-nokogiri ruby-ffi \
  ruby-dev libffi-dev build-essential \
  zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev

COPY Gemfile ./
RUN bundle
