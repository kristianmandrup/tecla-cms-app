# CMS image customized for another environment

FROM cms
MAINTAINER Kristian Mandrup <kmandrup@gmail.com>

# Set the proper environment
ENV RAILS_ENV production

# Custom settings for that environment
ADD .env /usr/src/app/.env
ADD mongoid.yml /usr/src/app/config/mongoid.yml

# Allows the user to write the precompiled assets
RUN rake assets:precompile

# Exposes the public directory as a volume
VOLUME /usr/src/app/public
