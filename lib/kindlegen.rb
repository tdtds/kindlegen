require "kindlegen/version"
require 'pathname'
require 'systemu'

module Kindlegen
  Root = Pathname.new(File.expand_path('../..', __FILE__))
  Bin  = Root.join('bin')
  Executables = Bin.children.inject({}) { |h, p|
    h[p.basename.to_s.to_sym] = p.to_s
    h
  }

	#
	# Getting command path of kindlegen.
	#
	def self.command
    Executables[:kindlegen]
	end

	#
	# Run kindlegen command with spacified parameters
	#
	# _params_:: array of command parameters.
	#
	def self.run( *params )
		systemu command + ' ' + params.join( ' ' )
	end
end
