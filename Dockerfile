FROM ruby:latest

# Updates our package manager registry and removes anything in /lists
RUN apt-get update && rm -rf /var/lib/apt/lists/*

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

# Creates our Working directory
RUN mkdir -p /usr/src/app

# Sets our Working directory (from where our commands will execute)
WORKDIR /usr/src/app

# Copies our Gemfile onto image
ADD Gemfile /usr/src/app/
ADD Gemfile.lock /usr/src/app/

# Runs bundle install on Gemfile from our Working dir
RUN bundle install

# Copies our app into /usr/src/app on the image
ADD . /usr/src/app

# Expose our Rails app port 3000
EXPOSE 3000

# Runs our Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
