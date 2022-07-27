# frozen_string_literal: true

# SocialNetworks controller
class SocialNetworksController < ApplicationController
  ENDPOINTS = %w[twitter facebook instagram].freeze
  EXCEPTIONS = [SocketError, Net::OpenTimeout].freeze
  BASE_URL = 'https://takehome.io/'

  def index
    @result = {}

    threads = ENDPOINTS.collect do |endpoint|
      Thread.fork { fetch_data(endpoint) }
    end

    threads.map(&:join)
    render json: @result
  end

  private

  def fetch_data(endpoint)
    url = "#{BASE_URL}#{endpoint}"
    response = HTTParty.get(url)
    response = fetch_data(endpoint) unless response.success?
    @result[endpoint] = response.body
    response
  rescue *EXCEPTIONS => e
    Rails.logger.debug e.message
    fetch_data(endpoint)
  end
end
