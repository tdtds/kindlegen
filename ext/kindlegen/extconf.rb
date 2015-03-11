#
# making Makefile getting kindlegen from Amazon.com
#

require 'rbconfig'
File::open('Makefile', 'w') do |w|
  tarball = case RbConfig::CONFIG['host_os']
  when /mac|darwin/i
    unzip = 'unzip'
	 "KindleGen_Mac_i386_v2_9.zip"
  when /linux|cygwin/i
    unzip = 'tar -zx --no-same-owner -f'
	 "kindlegen_linux_2.6_i386_v2_9.tar.gz"
  when /mingw32/i
    unzip = 'unzip'
    "kindlegen_win32_v2_9.zip"
  else
    STDERR.puts "Host OS unsupported!"
    exit(1)
  end

  config = RbConfig::CONFIG.merge({
    "unzip" => unzip,
    "tarball" => tarball
  })

  bindir = File.join(File.expand_path('../../..', __FILE__), "bin")
  w.puts RbConfig.expand(DATA.read, config.merge('bindir' => bindir))
end


__END__
AMAZON = http://kindlegen.s3.amazonaws.com
TARGET = kindlegen
BINDIR = $(bindir)
TARBALL = $(tarball)
CURL = curl
UNZIP = $(unzip)
CP = cp -a
MKDIR = mkdir -p

all:

$(TARGET): $(TARBALL)
	$(UNZIP) $(TARBALL)
	touch $(TARGET)
	chmod +x $(TARGET)

$(TARBALL):
	$(CURL) $(AMAZON)/$(TARBALL) -o $(TARBALL)

install: $(TARGET)
	$(MKDIR) $(BINDIR)
	$(CP) $(TARGET) $(BINDIR)
