#!/bin/bash
# Deploy to WP Engine via git push.
#
# Add the following environment variables to your project configuration.
# Make sure created a developer user to your WP Engine install with the Codeship projects SSH key.
# * GIT_USER_NAME
# * GIT_USER_EMAIL
# * WPENGINE_INSTALL
# * WPENGINE_ENVIRONMENT - production or staging

# Set git configs
git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"
# Add WP Engine remote
git remote add staging git@git.wpengine.com:$WPENGINE_ENVIRONMENT/$WPENGINE_INSTALL.git
git checkout -b feature-add-requirements
# Install composer dependencies
composer install
# Add composer dependencies to repo
git add --force wp-content/vendor
git commit -m "feat(vendor): add composer dependencies"
# Install and run gulp
cd wp-content/themes/theme-name
# Speed up npm install a little bit
npm set progress=false
npm config set registry http://registry.npmjs.org
npm -g install npm@latest
npm -g install bower
npm install
bower install
gulp --production
cd ../../../
# Add gulp generated files to repo
git add --force wp-content/themes/theme-name/dist
git add --force wp-content/themes/theme-name/bower_components
git commit -m "feat(vendor): add gulp generated files"
git checkout master
git merge feature-add-requirements
git branch -d feature-add-requirements
# Push to WP Engine
git push -f staging master
