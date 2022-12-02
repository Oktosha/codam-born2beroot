# codam-born2beroot

Some notes on born2beroot project at Codam

## Extra info

You don't need to know it to pass the project, but it is fun/useful

### Increasing the screen size of virtual machine

basic (up to 1280x1024) https://www.ronaldtoussaint.nl/2018/01/24/increasing-the-screen-resolution-of-linux-console-with-grub-in-virtualbox/

I tried to increase it further, but it didn't work. I added a custom resolution like this: https://docs.oracle.com/en/virtualization/virtualbox/6.0/admin/adv-display-config.html but than I had problem that my framebuffer was too small and I wasn't able to increase it even with fbset.

### TTYs

By default you have 6 terminals open, and you can switch between them with
`alt + F1`, `alt + F2`, ...` alt + F6`. With the default Mac host settings you'll need to press `fn` as well to make `F1`, `F2`, …, `F6` work. And if there is a graphics interface on your linux you'll also need `control`.

Another way to change between terminals is `chvt` command, i. e. `chvt 3` to change to tty3. When you execute `chtv` via ssh, the terminal is changed in the virtual machine window.

An article on terminals: http://www.linusakesson.net/programming/tty/index.php 

### Using less

One can pipe long output into `less` to be able to navigate it. For example `lsblk -h | less`. Type `q` to exit, type `/pattern` to find the pattern, type `n` to go to the next occurence, type `N` for previous occurence. Also, see `man less`.

But I reccoment ssh into your virtual machine from the host and use comfortable terminal with scroll and copy-paste.

### Env variables

`export` - set
`env` - print
`unset` - unset

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

