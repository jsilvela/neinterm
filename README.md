# neinterm

This is a total doodle of a project for now. Want to make something like `9term`,
and want to make it in `tcl/tk` for the frontend, and perhaps a
Go backend.

## motivation

There are many useful programs written as command-line tools. Using them from
a terminal emulator carries some problems due to the model of terminal interaction:

* Newlines, in a terminal, send the line to the shell. In order to type multi-line
  commands, we need to put a `\` at the end of the line.
  While this may make sense for the shell, the terminal emulator will impose the
  same model on any program used in it.
* History is an unnatural mechanism which made sense with teletypes, but not with
  multiline, editable windows. In your text editor, you don't ever ask to re-type
  the last paragraph.
* Editing a command in the terminal calls for a hack. The cursor keys may not have
  the screen-navigation functinoality. To get around this, some programs
  compile in the `readline` library, which may itself induce incompatibilities, and
  make it difficult to interoperate with windows.

The Plan9 terminal, the `rc` shell, the paginator (`p` rather than `more`), the
Acme editor, do away
with terminal emulators, and assume a "dumb" terminal. I think that is a very good
way to go. I don't agree with every choice made by those tools, however, so this
is an attempt to take the ideas and apply them to something more in line with current
practices.

## objectives

* to offer a text window for interaction with a text based program. For instance, with
  database command-lines. This window should behave like a text editor, not like
  a terminal emulator. Pressing enter should create a newline, the cursor keys
  should move around the window, and the mouse should work fully.
* arbitrary selections in the text window should be *sent* to the underlying text based
  program with a mouse command or with a key combination.
* emulate Acme's mouse-chording for copying and pasting, and for command execution.
* different modes of interaction may be explored. Concatenating input and output in the same
  window does not always make sense. If we need to repeat commands often, it may
  be more convenient to have separate input and output areas.
* take advantage of the offerings of operating systems. Let them handle text rendering,
  scrolling, cursor key navigation.

## inspiration

* Plan9 in general, Acme in particular
* The Smaltalk/Squeak model: transcript, not terminal. Command output selected and
  discardable with one click.
* The [DrScheme functional REPL:](https://cs.brown.edu/~sk/Publications/Papers/Published/fffkf-drscheme-journal/paper.pdf)
  > DrScheme provides and enforces this batch-oriented style of interactive program
  > evaluation in a natural way. When the programmer is ready to test a program,
  > a click on the Execute button submits the program to the interactions window."
