#
# making Makefile getting kindlegen from Amazon.com
#

require 'rbconfig'
File::open('Makefile', 'w') do |w|
  tarball = case RbConfig::CONFIG['host_os']
  when /mac|darwin/i
    unzip = 'unzip'
    "KindleGen_Mac_i386_v2_4.zip"
  when /linux|cygwin/i
    unzip = 'tar zxf'
    "kindlegen_linux_2.6_i386_v2_4.tar.gz"
  else
    STDERR.puts "Host OS unsupported!"
    exit(1)
  end

  config = {
    "unzip" => unzip,
    "tarball" => tarball
  }

	if Dir::pwd.include? 'gems'
		w.puts RbConfig.expand(DATA.read, config.merge('bindir' => '../../../../bin') )
	else
		w.puts RbConfig.expand(DATA.read, config)
	end
end


__END__
AMAZON = http://s3.amazonaws.com/kindlegen
TARGET = kindlegen
BINDIR = $(bindir)
TARBALL = $(tarball)
CURL = curl
UNZIP = $(unzip)
CP = cp

all:

$(TARGET): $(TARBALL)
	$(UNZIP) $(TARBALL)
	touch $(TARGET)

$(TARBALL):
	$(CURL) $(AMAZON)/$(TARBALL) -o $(TARBALL)

install: $(TARGET)
	$(CP) $(TARGET) $(BINDIR)
