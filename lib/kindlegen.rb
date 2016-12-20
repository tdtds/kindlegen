require "kindlegen/version"
require 'pathname'
require 'rbconfig'
require 'open3'

module Kindlegen
  Root = Pathname.new(File.expand_path('../..', __FILE__))
  Bin  = Root.join('bin')

  #
  # Getting command path of kindlegen.
  #
  def self.command
    Bin.join('kindlegen')
  end

  #
  # Run kindlegen command with spacified parameters
  #
  # _params_:: array of command parameters.
  #
  def self.run( *params )
    clean_env{Open3.capture3(command.to_s, *params)}.map do |r|
      r.force_encoding('UTF-8') if windows? && r.respond_to?(:force_encoding)
      r
    end
  end

private
  def self.clean_env
    env_backup = ENV.to_h
    ENV.clear
    ENV['TEMP'] = env_backup['TEMP'] if windows?
    ret = yield
    ENV.replace(env_backup)
    return ret
  end

  def self.windows?
    RbConfig::CONFIG['host_os'] =~ /mingw32|mswin32/i
  end
end
