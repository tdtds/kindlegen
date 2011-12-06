# Kindlegen

Easy to install kindlegen command via gem!

When you will run this gem, it will download tarball of kindlegen from amazon.com and extract it. Then you can find command file in "$GEMPATH/bin".

## Using from Ruby

Require kindlegen module, you can run kindlegen command without you know its path.

### Kindlegen.command

returning path of kindlegen command.

### Kindlegen.run( *args )

runing kindlegen command with specified parameters.

### Example
    require 'kindlegen'
    Kindlegen.run( "sample.opf", "-o sample.mobi" )
 

