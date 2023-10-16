FROM ruby:3
WORKDIR /docs
COPY Gemfile /docs/
RUN apt-get update
RUN apt-get -y install rsync default-jre graphviz
RUN bundle install 
