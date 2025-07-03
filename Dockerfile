FROM ruby:3.4.4

#RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
#ENV NODE_MAJOR=20
#RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
# Ensure node.js 19 is available for apt-get
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash -

# Install dependencies
RUN apt-get update
RUN apt-get install -y build-essential libvips  nodejs && npm install -g yarn

# Install Google Chrome Stable and fonts
# Note: this installs the necessary libs to make the browser work with Puppeteer.
RUN apt-get update && apt-get install gnupg wget -y && \
  wget --quiet --output-document=- https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /etc/apt/trusted.gpg.d/google-archive.gpg && \
  sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
  apt-get update


RUN apt-get install -y s3cmd gnupg2 libproj-dev proj-bin imagemagick  letsencrypt libmagickcore-dev libmagickwand-dev awscli nginx python3-pip python3-dev  redis libpq-dev python3-psycopg2 acl certbot  python3-certbot-nginx  libgbm-dev libxkbcommon-x11-0 libgtk-3-0

RUN apt-get install -y libpoppler-glib8 libglib2.0-dev  libvips  libturbojpeg-dev autoconf bison patch build-essential rustc uuid-dev libgdbm6 libgdbm-dev libgirepository-1.0-1 libgirepository1.0-dev libpoppler-glib-dev

RUN apt-get install -y poppler-utils
# Mount $PWD to this workdir
WORKDIR /rails

# Ensure gems are installed on a persistent volume and available as bins
VOLUME /bundle

# Configure bundler
ENV LANG=C.UTF-8
ENV BUNDLE_JOBS=8
ENV BUNDLE_RETRY=3

# Store Bundler settings in the project's root
#ENV BUNDLE_APP_CONFIG=.bundle

# Upgrade RubyGems and install the latest Bundler version
RUN gem update --system && gem install bundler


# Install Chrome dependencies
RUN apt-get install -y fonts-liberation libasound2 libatk-bridge2.0-0 libatk1.0-0 libatspi2.0-0 libcairo2 libcups2 libdbus-1-3 libdrm2 libgbm1 libglib2.0-0 libnspr4 libnss3 libpango-1.0-0 libx11-6 libxcb1 libxcomposite1 libxdamage1 libxext6 libxfixes3 libxkbcommon0 libxrandr2 xdg-utils

# Install Chrome for headless browsing
# RUN curl -LO https://dl.google.com/linux/direct/google-chrome-stable_current_arm64.deb
# RUN dpkg -i ./google-chrome-stable_current_arm64.deb
# RUN rm google-chrome-stable_current_arm64.deb

# # Verify Chrome installation
# RUN google-chrome --version
# ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome
RUN bundle config set --global path '/bundle'
ENV PATH="/bundle/ruby/${RUBY_VERSION}/bin:${PATH}"
ENV RUBY_YJIT_ENABLE true

ENV npm_config_arch=arm64
# Install Rails
#RUN bundle install
#RUN yarn install

#RUN chown -R node /rails/node_modules

# Ensure binding is always 0.0.0.0, even in development, to access server from outside container
ENV BINDING="0.0.0.0"

# Overwrite ruby image's entrypoint to provide open cli
ENTRYPOINT [""]