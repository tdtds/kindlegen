require "kindlegen/version"
require 'pathname'
require 'systemu'

module Kindlegen
	#
	# Getting command path of kindlegen.
	# If it required under gem, returning path in the extension.
	# Not if, it return simply 'kindlegen' so you have to copy the command into $PATH.
	#
	def self.command
		if __FILE__.include? 'gems'
			(Pathname( __FILE__ ).parent + '../ext/kindlegen/kindlegen').to_s
		else
			'kindlegen'
		end
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
