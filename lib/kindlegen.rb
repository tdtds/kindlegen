require "kindlegen/version"
require 'pathname'
require 'rbconfig'
require 'shellwords'
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
    cmdline = create_commandline(params)
    msg = nil
    if windows?
      msg, _ = Open3.capture2e(cmdline)
      msg.force_encoding('utf-8')
    else
      clean_env { msg, _ = Open3.capture2e(cmdline) }
    end
    puts msg.gsub(/\n+/, "\n")
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
