require 'test/unit'
require 'rubygems/uninstaller'
KINDLEGEN_PROJECT_DIR = File.expand_path(File.dirname(File.dirname(__FILE__)))
$:.delete(File.join(KINDLEGEN_PROJECT_DIR, 'lib'))

class KindlegenTest < Test::Unit::TestCase
  def test_gem_install
    gem_version = File.read(File.join(KINDLEGEN_PROJECT_DIR, 'lib/kindlegen/version.rb')).match(/VERSION = "(.*?)"/)[1]
    gem_file = File.join(KINDLEGEN_PROJECT_DIR, 'pkg', %(kindlegen-#{gem_version}.gem))
    Gem.install gem_file
    require 'kindlegen'
    output = %x(#{Kindlegen.command})
    assert output.include?('Amazon')
  ensure
    Gem::Uninstaller.new('kindlegen', :force => true).uninstall rescue nil
  end
end
