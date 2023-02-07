# codam-born2beroot

Some notes on born2beroot project at Codam

## Increasing the screen size of virtual machine

basic (up to 1280x1024) https://www.ronaldtoussaint.nl/2018/01/24/increasing-the-screen-resolution-of-linux-console-with-grub-in-virtualbox/

I tried to increase it further, but it didn't work. I added a custom resolution like this: https://docs.oracle.com/en/virtualization/virtualbox/6.0/admin/adv-display-config.html but than I had problem that my framebuffer was too small and I wasn't able to increase it even with fbset.

## TTYs

By default you have 6 terminals open, and you can switch between them with
`alt + F1`, `alt + F2`, ...` alt + F6`. With the default Mac host settings you'll need to press `fn` as well to make `F1`, `F2`, …, `F6` work. And if there is a graphics interface on your linux you'll also need `control`.

Another way to change between terminals is `chvt` command, i. e. `chvt 3` to change to tty3. When you execute `chtv` via ssh, the terminal is changed in the virtual machine window.

An article on terminals: http://www.linusakesson.net/programming/tty/index.php 

## Using less

One can pipe long output into `less` to be able to navigate it. For example `lsblk -h | less`. Type `q` to exit, type `/pattern` to find the pattern, type `n` to go to the next occurence, type `N` for previous occurence. Also, see `man less`.

But I reccoment ssh into your virtual machine from the host and use comfortable terminal with scroll and copy-paste.

## Env variables

`export` - set
`env` - print
`unset` - unset

## change default editor

`update-alternatives --config editor` (updates the editor system-wide)

## Changing users

`su --login {username}` or `su - {username}` changes user. Without `--login`/`-` will not change env variables properly.

## LVM

The easiest way to achive the partition for mandatory part is to use guided partition during the debian install. But here is a nice article on LVM anyway: https://www.redhat.com/sysadmin/lvm-vs-partitioning

`lsblk` — command to see disk partition info.

`lsblk --list -o NAME,TYPE | grep lvm` shows logical volumes created by lvm.

Also, here is the [source code for lsblk](https://github.com/util-linux/util-linux/blob/master/misc-utils/lsblk.c#L417-L471) (link to the function that gets the type of the device). Basically, lsblk goes through folders in `/sys/block` and somehow retrieves info about devices. The type of a dm (see [device mapper](https://en.wikipedia.org/wiki/Device_mapper)) device is determined by looking at `/sys/block/dm-1/dm/uuid`


## SSH

`sshd -T` see settings

`/etc/ssh/sshd_config` - set settings

ssh into virtualbox machine https://averagelinuxuser.com/ssh-into-virtualbox/

## UFW

https://help.ubuntu.com/community/UFW

`ufw status verbose` shows ufw status

`lsof` - list all open files; `lsof -i` - files for Internet

Or, a better way from the subject - `ss -tunlp` (overlooked it at first).

[Why isn't ping shown in `netstat`?](https://www.quora.com/Why-doesnt-the-netstat-command-display-any-information-about-ICMP-connections)

## Hostname

`hostnamectl set-hostname {new hostname}` + change `/etc/hosts`

Check via `hostnamectl`

## Groups

`groups` shows groups of current user

`groups {username}` shows groups of `{username}`

`id [{username}]` shows groups with group ids, also shows which groups if primary for the user.

`groupadd {groupname}` create group

`usermod -a -G {groupname(s)} {username}` add user to a group. With `-g` makes the group primary for user. Without `-a` all non-listed groups will be erased (except for the primary?)

`gpasswd -a {user} {group}` add user to group.

`gpassed -d {user} {group}` delete user from group.

## Users

`useradd` low level user creation

`adduser` hight level user creation


## Password strength

First, install `libpam-pwquality`.

Config is stored in `/etc/security/pwquality.conf`

The `pwquality` module is somehow automatically added to `/etc/pam.d/common-password`

`pwscore` checks passwords. Install with `apt-get install libpwquality-tools`. Accepts username as an argument to check for similarities.

## Password managment

`passwd` change password

`chage` set expiration data for exisiting users

`/etc/login.defs` - expiration data defaults

## Sudo

`visudo` - change sudo settings

`ssh localhost -p 2022 'sudo -S echo "Hello"'` way to check `requiretty`

`Defaults        env_reset,timestamp_timeout=0` ask for password every time

if `secure_path` is set, than `sudo` looks for executables there. My example executable lies in `/usr/local/games` which is in `PATH` but not in `secure_path` so sudo doesn't see it. If I want to run such an executable, I need `sudo $(which MY_EXECUTABLE) ARGUMENTS`.

You can look at the sudo session with `sudoreplay -d /var/log/sudo -l` and then replay a session with `sudoreplay -d /var/log/sudo TSID`.


# CPU load

`sudo apt-get install sysstat` — better CPU monitoring than top.

`mpstat 2 1` gives 1 data point about 2-second interval.

## MISC

Fancy ascii banners https://manytools.org/hacker-tools/ascii-banner/

Save if forgot to call vim with sudo: `:w !sudo tee %` [link](https://www.cyberciti.biz/faq/vim-vi-text-editor-save-file-without-root-permission/)

Hold `alt` to select in iTerm for copying to clipboard of the host machine.

To enter a folder with a name starting with `-` use `--`, i. e. `cd -- -2`