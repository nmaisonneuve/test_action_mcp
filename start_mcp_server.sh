#!/bin/bash -l
rvm use ruby-3.4.4
bundle update
bundle exec falcon serve --bind http://0.0.0.0:62770 -c mcp_vanilla.ru