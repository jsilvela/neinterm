#!/usr/bin/env wish

text .text -relief raised -bd 2 \
	-yscrollcommand {.scroll set} -font {consolas 13} \
	-spacing1 10 -spacing2 10

bind .text <KeyRelease> {
	if {"%K" == "Return"} {
		eval_command
		prompt
	}
}

scrollbar .scroll -command {.text yview}
grid .text -row 0 -column 0 -sticky nsew
grid .scroll -row 0 -column 1 -sticky ns

proc eval_command {} {
	set pg [open {|psql testdb } r+]
	set f [open README.md]

	# start +1 to skip the space, insert -1 to skip the newline
	set command [.text get "start + 1 chars" "insert - 1 chars"]
	puts  "< $command >"

	puts $pg $command
	flush $pg

	# .text delete 1.0 end

	while {[gets $pg line] > 0} {
		puts $line
		.text insert end $line
	}

	puts Done

	close $pg
	close $f
}

proc prompt {} {
	.text insert end "$ "
	# todo: without the -1 this does not work. Why?
	.text mark set start "insert - 1 chars" 
}

prompt