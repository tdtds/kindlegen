# Kindlegen

Easy to install kindlegen command via gem.

When you run this gem, it will download a tarball of kindlegen from amazon.com and extract it. Then you can find the command file in "$GEMPATH/bin".

## Using from Ruby

Require `kindlegen`, then run kindlegen commands.

### Kindlegen.command

Returns the path of the kindlegen command.

### Kindlegen.run( *args )

Runs the kindlegen command with specified parameters.

### Example
    require 'kindlegen'
    Kindlegen.run("sample.opf", "-o", "sample.mobi")
 

