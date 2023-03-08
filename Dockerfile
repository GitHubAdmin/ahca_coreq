# docker build --progress=plain -t local/services_tools:latest .
FROM ruby:2.6.10-buster

RUN apt-get update -qq && \
  apt-get install -y vim \
    bash-completion \
    expect

COPY . /app

WORKDIR /app/
RUN gem install bundler
RUN bundle

RUN mkdir -p /root/.ssh
RUN echo "alias l='ls -alh'" >> ~/.bashrc

CMD ["/bin/bash"]

