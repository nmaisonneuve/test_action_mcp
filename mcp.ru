# frozen_string_literal: true

# MCP Vanilla Server Configuration

# This configuration file creates a minimal Rack application for the MCP server
# with only the essential middleware needed for ActionMCP to function properly.
#
# USE THIS FILE when your main Rails application has middleware that interferes
# with MCP server operation, such as:
# - Devise/Warden (authentication middleware expecting cookies and sessions)
# - Ahoy (analytics tracking that intercepts requests)
# - Rack::Attack (rate limiting that might block MCP clients)
# - Rack::Cors (CORS headers that confuse AI assistants about their origin)
# - Custom authentication middleware
# - That sketchy middleware your coworker wrote at 3am that "temporarily" fixes login
# - The middleware that rejects any password except "hunter2" (we see you, IRC veteran)
# - Any middleware that expects web browser requests rather than API requests
#
# The Rails architecture makes engines inherit ALL middleware from the main app,
# which works great for 99% of use cases but can cause conflicts for protocol-specific
# servers like ActionMCP that don't need cookies, sessions, or authentication.
#
# To use this file:
# bundle exec rails s -c mcp_vanilla.ru -p 62770
# Or with Falcon:
# bundle exec falcon serve --bind http://0.0.0.0:62770 mcp_vanilla.ru

# Load the Rails environment
require_relative "config/environment"

# Ensure STDOUT is not buffered
$stdout.sync = true # for falcon

# Handle Ctrl+C gracefully when using Puma with streaming connections
Signal.trap("INT") do
  puts "\nReceived interrupt signal. Shutting down gracefully..."
  exit(0)
end

Signal.trap("TERM") do
  puts "\nReceived termination signal. Shutting down gracefully..."
  exit(0)
end

Rails.application.eager_load!

run ActionMCP.server