#
# making Makefile getting kindlegen from Amazon.com
#

require 'rbconfig'
File::open('Makefile', 'w') do |w|
  case RbConfig::CONFIG['host_os']
  when /mac|darwin/i
    unzip = 'unzip'
    tarball = 'KindleGen_Mac_i386_v2_9.zip'
    target = 'kindlegen'
  when /linux|cygwin/i
    unzip = 'tar -zx --no-same-owner -f'
    tarball = 'kindlegen_linux_2.6_i386_v2_9.tar.gz'
    target = 'kindlegen'
  when /mingw32/i
    unzip = 'unzip'
    # Abort if either `unzip' or `curl' if not found
    `where #{unzip}`
    unless ($?.success?)
      STDERR.puts "The program `unzip' not found. Aborting."
      exit(1)
    end
    `where curl`
    unless ($?.success?)
      STDERR.puts "The program `curl` not found. Aborting."
      exit(1)
    end 
    tarball = 'kindlegen_win32_v2_9.zip'
    target = 'kindlegen.exe'
  else
    STDERR.puts "Host OS unsupported!"
    exit(1)
  end

  bindir = File.join(File.expand_path('../../..', __FILE__), "bin")

  config = RbConfig::CONFIG.merge({
    "unzip" => unzip,
    "tarball" => tarball,
    "target" => target,
    "bindir" => bindir,
  })

  w.puts RbConfig.expand(DATA.read, config)
end


__END__
AMAZON = http://kindlegen.s3.amazonaws.com
TARGET = $(target)
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
