# The bash from hell

This is inspired by ["The Bastard Operator From Hell"](http://bofh.bjash.com/bofh/bofh10.html)

In [this story](http://bofh.bjash.com/bofh/bofh10.html), he tells a student to check his spelling with the spell command which he modified:

> Especially as I know that my version of spell INTRODUCES errors instead of detecting them. Things like changing friend to freind and vice-versa

# The idea

This .bashrc is should break the expected behaviour of basic linux commands and make a system unusable.

# cd 

## `cd`

#### Expected behaviour

If no directory operand is given and the HOME environment variable is set to a non-empty value, the  cd  utility  shall behave as if the directory named in the HOME environment variable was specified as the directory operand.

#### Changed to

If no directory operand is given, the cd utility shall behave as if a seemingly random directory was specified as the directory operand.

## `cd ..[/*]`

#### Expected behaviour

Follow directory operand.

#### Changed to

Follow directory or add another `../` in front of the directory operand.

## `cd <dir>`

#### Expected behaviour

Follow directory operand.

#### Changed to

Follow directory or change it to `/`.

## `nano [args]`

#### Expected behaviour

Open text editor nano

#### Changed to

Open vim or emacs instead of nano if installed.

## `exec bash`

#### Expected behaviour

Leave .bashrc if not default.

#### Changed to

Echo message.

## `ls`

#### Expected behaviour

List directory contents.

#### Changed to

List directory contents unsorted and with hard to read colours.
