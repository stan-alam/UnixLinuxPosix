##Chap01 Sed Syntax and Basic commands

**Sed stands for Stream editor**

A tool to manipulate, filter and transform text. Sed takes input from a pipe.

**Basic sed syntax**

sed [options] {sed-commands} {input-file}

Sed reads one line at a time from the {input-file} and executes the {sed-commands} on that particular line.

**basic sed syntax**

    sed -n 'p' /etc/passwd

sed commands can be combined into multiple sed-commands in a file called the sed script.

**Basic sed syntax for use with sed-command file:**

    sed [options] -f {sed-commands-in-a-file} {input-file}

to execute mulitple sed commands use the -e flag

	sed -n -e '/^root/ p' -e '/^nobody/ p' /etc/passwd

	and for executing multiple commands in a single line

	sed -n \
	-e '/^root/ p' \
	-e '/^nobody/ p' \
	/etc/passwd


##2. Scripting flow in sed

