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
git checkout -b temp
# Install npm and the dependencies
cd wp-content/themes/theme-name
# Spped up npm install a little bit
npm set progress=false
npm config set registry http://registry.npmjs.org
npm install
npm install bower grunt-cli
# Install bower dependencies
bower install
# Run grunt task
grunt styles --force
# Add styles to repo
git add --force style.css style.css.map style.min.css
cd ../../../
git commit -m "feat(css): add generated styles"
git checkout master
git merge temp
git branch -d temp
# Push to WP Engine
git push -f staging master
