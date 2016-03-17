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
# Push to WP Engine
git push staging master
