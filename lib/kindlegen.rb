require "kindlegen/version"
require 'pathname'
require 'rbconfig'
require 'shellwords'

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
    cmdline = create_commandline(params)
    if windows?
      system cmdline
    else
      clean_env { system cmdline }
    end
  end

private
  def self.clean_env
    env_backup = ENV.to_h
    ENV.clear
    ret = yield
    ENV.replace(env_backup)
    return ret
  end

  def self.windows?
    RbConfig::CONFIG['host_os'] =~ /mingw32|mswin32/i
  end

  def self.create_commandline(params)
    line = "#{command} "
    if windows?
      line << params.map { |x| x =~ /\s/ ? "\"#{x}\"" : x }.join(' ')
    else
      line << params.shelljoin
    end
  end
end
