gdb tips and tricks
===================

# Run gdb without printing all the licensing spiel
```
$ gdb -q
```
a useful bash alias is
```
alias gdb="gdb -q"
```

# Common commands

Get help for given command:
```
(gdb) help [command]
```

Search the help for commands related to `[word]`:
```
(gdb) apropos [word
```

Break on first line of program:
```
(gdb) start
```

Run program from beggining:
```
(gdb) run
```

Continue from breakpoint:
```
(gdb) continue
```

Execute current line:
```
(gdb) next
```

Set into function:
```
(gdb) step
```

Set forward one machine instruction:
```
(gdb) stepi
```

Finish executing function:
```
(gdb) finish
```

Print context around current line:
```
(gdb) list
```

Examine memory at address:
```
(gdb) x [address]]
```

Print the result of an expression:
```
(gdb) print [expression]
```

Print the type of an expression:
```
(gdb) ptype [expression]
```
or
```
(gdb) whatis [expression]
```

Evaluate an expression without printing its value:
```
(gdb) call [expression]
```

Print disassembly of current function:
```
(gdb) disassemble
```

Print the current stack frame:
```
(gdb) frame
```

Print current stack frame objects:
```
(gdb) info frame
```

List current files being debugged:
```
(gdb) info files
```

Print value every time the debugger stops (scope sensitive):
```
(gdb) display [value_name]
```

Attach to an already running process:
```
(gdb) attach [PID]
```

# TUI mode

Enter TUI mode:
```
(gdb) tui enable
```

Redraw the curses window (for when it gets messed up):
```
(gdb) refresh
```

Exit TUI mode:
```
(gdb) tui disable
```

Start gdb in TUI mode:
```
$ gdb -tui
```

# Breakpoints

Breakpoints stop execution of the program at a particular point optionally
subject to certain conditions.

Set breakpoint on line:
```
(gdb) break [filename:line_number]
```

Set breakpoint on function:
```
(gdb) break [function_name]
```

Set a breakpoint on all functions matching a regex:
```
(gdb) rbreak [regexp]
```

Set a conditional breakpoint (will only be hit if the condition evaluates to
true):
```
(gdb) break [location] if [condition]
```

Set a conditional breakpoint using target specific ABI (`rdi` is register
destination index on x86):
```
(gdb) break [location] if ($rdi == 42)
```

List breakpoints:
```
(gdb) info breakpoints
```

Disable breakpoint:
```
(gdb) disable [breakpoint_number]
```

Enable breakpoint:
```
(gdb) disable [breakpoint_number]
```

Clear breakpoint at specific location:
```
(gdb) delete [location]
```

Clear breakpoint at current line:
```
(gdb) delete
```

Delete breakpoint:
```
(gdb) delete [breakpoint_number]
```

Delete all breakpoints:
```
(gdb) delete
```

Add hooks to break point to execute when it is hit
```
(gdb) command [breakpoint_number]
enter your commands here
end
```

Set an environment variable in the inferior:
```
(gdb) set environment [name]=[value]
```

Debug a program in a process launched by the inferior (will stop whenever there
is a `fork()` and debugs the child:
```
(gdb) set follow-fork-mode child
```

List libraries loaded by dynamic linker:
```
(gdb) info sharedlibrary
```

Break whenever a program loads a shared library:
```
(gdb) set stop-on-solin-events on
```

Open `$EDITOR` on current line:
```
(gdb) edit
```

Update source paths for a binary created with source files in a different location:
```
(gdb) set substitute-path [from] [to]
```

Set the inferior to write its standard IO to somewhere other than the terminal
you are running gdb in:
```
(gdb) set inferior-tty [tty]
```

Disable address space layout randomization (ASLR) for intermittent memory issue
debugging:
```
(gdb) set disable-randomization
```

Cache symbols from shared libraries for quicker debugging of large programs:
```
(gdb) set index-cache on
```

Set the index cache directory to something other than `$PWD`:
```
(gdb) set index-cache directory [path]
```

# Watch points

Watchpoints are like breakpoints, except they are hit when the value of a
particular expression changes, rather than at a particular location. The
expression could be; a value of a variable, the content of a memory address, or
an arbitrary complex expression.

Watch the value of some expression:
```
(gdb) watch [expression]
```

Watch the value of the address of a variables (this is useful when you want to
continue watching the address of a variable even after it goes out of scope
since watch points respexts the scope of any varaibles in the expression):
```
(gdb) watch -location [variable]
```

Set watch point on specific thread:
```
(gdb) watch [watchpoint_number] thread [thread_id]
```

Set conditional watch point:
```
(gdb) watch [watchpoint_number] if [condition]
```

Watch a variable only for read operations:
```
(gdb) rwatch [expression]
```

Watch a variable for read or write accesses:
```
(gdb) awatch [expression]
```

Set a watchpoint on a specific address (gdb will refuse to watch a constant
value, we need to watch an expression, so here we cast to the type of value in
the address and then load it, the load is the thing being watched):
```
(gdb) watch *([type] *) [address]
```

List watchpoints:
```
(gdb) info watchpoints
```

Disable watchpoint (same as breakpoint):
```
(gdb) disable [watch_point_number]
```

Enable watchpoint (same as breakpoint):
```
(gdb) enable [watch_point_number]
```

Delete watchpoint by number (same as breakpoint):
```
(gdb) delete [watch_point_number]
```

Delete all watchpoints (same as breakpoint):
```
(gdb) delete
```

# Python interpretor
gdb has a very powerful built in python interpretor that is tightly coupled to
the debugger. Can be used to build new gdb commands, access debugging objects
e.g. breakpoints and do things like define pretty printers for C++ classes.
The python interpretor is run within gdb itself, it isn't just a forked process.

Execute aribrary python code:
```
(gdb) python
import os
print ('my pid is %d', os.getpid())
end
```

Source a python file in gdb:
```
(gdb) source [filename]
```

The `gdb` module gives access to gdb features

Get help for the python module:
```
(gdb) python help(gdb)
```

Execute arbitrary gdb commands:
```
(gdb) python gdb.execute('next')
```

Print breakpoints from python:
```
(gdb) python print(gdb.breakpoints[0].location)
```

Set breakpoints from python:
```
(gdb) python gdb.Breakpoint('7')
```

# Execute arbitrary shell command
You can run any bash/shell command in gdb.

Execute arbitrary shell command:
```
(gdb) shell [shell-command]
```


# Reversible debugging

gdb has built in reversible debugging.

Start a recording:
```
(gdb) record
```

Backwards command:
```
(gdb) reverse-[regular command name e.g. step]
```

## Run program with recording until it segfaults

Useful for sporadic segfaults, we can run a program in a loop, recording each
iteration until it fails, then use reversible debugging with the following
method:
```
(gdb) start
(gdb) break main
(gdb) b _exit
(gdb) command 3
run
end
(gdb) command 2
record
continue
end
(gdb) set pagination off
(gdb) run
```

# Useful settings

Turn of gdb's built-in paging
```
(gdb) set pagination off
```

Preserve history for future gdb sessions:
```
(gdb) set history save on
```

Set the history directory to something other than `$PWD`:
```
(gdb) set history filename [path]
```

Enable shell style history expansion
```
(gdb) set history expansion on
```

Make struct printing a bit nicer
```
(gdb) set print pretty on
```

Don't ask for confirmation on dangerous operations.
```
set confirm off
```

You can add any configuration settings to a `~/.gdbinit` file that will be run
at start up to avoid having to set these in each debugging session.

# Open gdb with a core dump
If a program segfaults and you have a core dump, you can open it with gdb and
examine the state of the program at the time it crashed.

Open a core dump with gdb:
```
$ gdb -c [core_dump]
```

# Threads
gdb supports debugging multi threaded programs:

List threads:
```
(gdb) info threads
```

Switch to thread i:
```
(gdb) thread i
```

# Convenience variables

Printing expressions in gdb will assign them to convenience variables that can
then be used in further expressions.

Assign and use a convenience variable (`int foo = 42` in the inferior):
```
(gdb) p foo
$1 = 42
(gdb) p $1 + 42
$2 = 46
```
