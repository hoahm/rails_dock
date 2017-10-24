FROM ruby:2.4.1

LABEL Description="This is an example of setting development environment using Docker compose."
LABEL Version="1.0"
LABEL Maintainer="Hoa Hoang <nobi.hoa@hmail.com>"


# Set this environment variable to true to set timezone on container start.
ENV SET_CONTAINER_TIMEZONE true

# Default container timezone as found under the directory /usr/share/zoneinfo/.
ENV CONTAINER_TIMEZONE Asia/Ho_Chi_Minh

# Set lang
ENV LANG C.UTF-8


# Update package lists
RUN apt-get update -qq
RUN apt-get upgrade -y


# Install dependencies
RUN apt-get install -y \
    automake \
    bison \
    build-essential \
    curl \
    git-core \
    libcurl4-openssl-dev \
    libffi-dev \
    libgdbm-dev \
    libncurses5-dev \
    libpq-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libtool \
    libxml2-dev \
    libxslt1-dev \
    libyaml-dev \
    nodejs \
    python-software-properties \
    sqlite3 \
    zlib1g-dev


# The main working dirctory
ENV APP_HOME /webapp
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME


# Do not install gems' document
RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc


# Bundle install gems
COPY Gemfile* $APP_HOME/
RUN gem install bundler --no-ri --no-rdoc
RUN bundle install --jobs 20 --retry 5


# Run entry point script
ADD docker-entrypoint.sh $APP_HOME/docker-entrypoint.sh
RUN chmod u+x $APP_HOME/docker-entrypoint.sh
ENTRYPOINT [$APP_HOME + "/docker-entrypoint.sh"]


# Expose port to the Docker host
EXPOSE 3000


# Run rails servers
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
