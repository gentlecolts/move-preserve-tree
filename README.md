# move-preserve-tree
A script to move the contents of folder A to folder B while preserving the original folder structure in A

# Usage and other info
> move.bat
this file is the old, batch version.  feel free to use it as it does work, but it has limitations:
- no support for unicode (unless cmd decides to do so at some point)
- kindof hacky
- not nearly as pretty as the bash version
- probably other wierd bugs that i havent found because quite frankly i dont care about a bash version
to actually run this script, `move.bat [source] [target]`

> movepreservetree.sh
usage: `movepreservetree.sh [source] [target]`
- note that if target does not already exist, it will be created
- at this time, folder properties are not transferred, this will be corrected when i can find a good way of doing so completely that works on linux and in cygwin, or when i stop caring about windows support
- mv is called with the default parameters, keep that in mind if [target] already has files in it