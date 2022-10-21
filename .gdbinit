# Turn off GDB's built-in paging.
set pagination off
# Set the history file somewhere that isn't in the way
set history filename ~/.cache/gdb/gdbhistory
# Preserve history between sessions.
set history save on
# Set the cache file somewhere that isn't in the way
set index-cache directory ~/.cache/gdb/gdbhistory
# Cache symbols from shared libraries for faster debugging
set index-cache on
# Enable shell style history expansion.
set history expansion on
# Make struct printing a bit nicer.
set print pretty on
# Don't ask for confirmation on dangerous operations.
set confirm off
