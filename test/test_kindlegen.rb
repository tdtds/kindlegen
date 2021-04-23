require 'test/unit'
require 'rubygems/installer'
require 'rubygems/uninstaller'
KINDLEGEN_PROJECT_DIR = File.expand_path(File.dirname(File.dirname(__FILE__)))
$:.delete(File.join(KINDLEGEN_PROJECT_DIR, 'lib'))

class KindlegenTest < Test::Unit::TestCase
  def test_gem_install
    kindlegen_lib_dir = nil
    gem_version = File.read(File.join(KINDLEGEN_PROJECT_DIR, 'lib/kindlegen/version.rb')).match(/VERSION = ["'](.*?)["']/)[1]
    gem_file = File.join(KINDLEGEN_PROJECT_DIR, 'pkg', %(kindlegen-#{gem_version}.gem))
	 result = Gem::Installer.at(gem_file).install rescue Gem::Installer.new(gem_file).install rescue Gem::Installer.new(Gem::Package.new gem_file).install
    begin
      require 'kindlegen'
    rescue ::LoadError
      Dir.glob(result.lib_dirs_glob).each do |path|
        $:.unshift path
      end
      require 'kindlegen'
    end
    output = %x(#{Kindlegen.command})
    assert output.include?('Amazon')
  ensure
    Gem::Uninstaller.new('kindlegen', :executables => true).uninstall rescue nil
    $:.delete kindlegen_lib_dir if kindlegen_lib_dir
  end
end
