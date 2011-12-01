#
# making Makefile getting kindlegen from Amazon.com
#

File::open( 'Makefile', 'w' ) do |w|
	w.puts RbConfig.expand( DATA.read )
end

__END__
AMAZON = http://s3.amazonaws.com/kindlegen
TARGET = kindlegen
BINDIR = $(bindir)
PLATFORM = linux_2.6_i386
VERSION = 1.2
TARBALL = $(TARGET)_$(PLATFORM)_v$(VERSION).tar.gz
CURL = curl
TARX = tar zxf
CP = cp

all: $(TARGET)

$(TARGET): $(TARBALL)
	$(TARX) $(TARBALL)
	touch $(TARGET)

$(TARBALL):
	$(CURL) $(AMAZON)/$(TARBALL) -o $(TARBALL)

install: $(TARGET)
	$(CP) $(TARGET) $(BINDIR)

