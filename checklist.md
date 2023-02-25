# Checklist

Here I go throgh all the questions in the subject and mark them answered.

## Things I have to know

* <details>
  <summary> 🤷 What is a virtual machine?</summary>

  Something-something, everything emulated. Heavier than a docker container.
  </details>
* <details>
  <summary> 🤷 How does virtual machine work?</summary>

  Host emulates a machine and tricks guest system to think it's installed on real computer.
  </details>
* <details>
  <summary> 🤷 What the purpose of a virtual machine?</summary>

  Something-something, security, reproducability, running stuff not possible on host system.
  </details>
* <details>
  <summary> 🤷 What is the difference between Debian and Rocky?</summary>

  Meh, they are both Linux. Rocky seems to be more difficult. Package managers are different and packages are different.
  </details>
* <details>
  <summary> 🤷 What are SELinux and AppArmor?</summary>

  Something-something security. Mandatory Access Control. AppArmor is easier but lacks Multi-Level Security. [Something on AppArmor vs SELinux](https://www.redhat.com/sysadmin/apparmor-selinux-isolation)
  </details>
* <details>
  <summary> 🤷 What is the difference between apt and aptitude?</summary>

  Different interfaces for package management. Aptitude is interface for both apt-get and dselect (dselect allows to flexibily choose ways to satisfy dependencies). `apt-get` is lower level than `apt`.
  </details>
* <details>
  <summary> 🤷 What is LVM?</summary>

  Logical volume manager something-something.
  </details>

## Checks

* <details>
  <summary> ✅ The latest stable release of Debian is used</summary>

  I don't know, how to check it reliably. Nothing better than `hostnamectl` or `uname -a`.
  </details>
* <details>
  <summary> ✅ No graphics server</summary>

  `apt list --installed | grep xorg` to check.
  Also can check for alternative graphics like Wayland in installed packages.
  </details>
* <details>
  <summary> ✅ Paritions are as expected </summary>

  `lsblk` to check. I even added the sr0 (CD-rom) back.
  </details>
* <details>
  <summary> ✅ Ssh runs on port 4242 only </summary>
  `systemctl status sshd` to check.
  </details>
* <details>
  <summary> ✅ It's not possible to connect as root through ssh </summary>

  `sshd -T` to check for active settings. Also can just try to ssh as root.
  </details>
* <details>
  <summary> ✅ UFW blocks incoming from every port except 4242 </summary>

  `ufw status verbose` to check.
  </details>
* <details>
  <summary> ✅ Hostname s dkolodze42 </summary>

  `hostnamectl` to check
  </details>
* <details>
  <summary> ✅ dkolodze user in groups user42 sudo </summary>

  `groups dkolodze` to check
  </details>

## Strong password policy

* <details> 
  <summary> ✅ All passwords are changed after finishing sudo setup</summary>
  
  `getent passwd {1000..60000}` to get usernames

  `su - [username]` to log into a user
  </details>
* <details>
  <summary> ✅ Passwords expire every 30 days (existing & new) </summary>
  
  `chage -l [username]` to get info for existing user

  Defaults for new users are stored in `/etc/login.defs`
  </details>
* ✅ Users receive a warning 7 days before expiration (existing & new)
* ✅ User can change password not earlier than after 2 days (existing & new)
* ✅ Password must be at least 10 characters long
* ✅ Password myst contain uppercase letter, lowercase letter and number
* ✅ Password can't have more than 3 consecutive identical characters
* ✅ The password must not include the name of the user
* ✅ The password must have at least 7 characters that are not part of the former password (except for the root)
* ✅ Every user complies with the policy, including root

## Sudo policy

* ✅ Authentication using sudo is limited to 3 attempts
* ✅ Error due to a wrong password with sudo is a custom message
* ❌ Each sudo action should be archived to /var/log/sudo (both inputs and outputs)
* ❌ TTY mode is enabled
* ✅ paths that can be used by sudo are restricted

## Changes during evaluation

* <details>
  <summary> ❌ Test ssh through setting up a new account </summary>

  `adduser` something-something. Check that password policy is respected.
  </details>
* <details>
  <summary> ❌ Change UFW rules </summary>

  `ufw` ??
  </details>
* <details>
  <summary> ❌ Change hostname </summary>

  `hostnamectl --set-hostname` ??
  </details>
* <details>
  <summary> ❌ Create a new user and assign it to a group </summary>

  `adduser` something-something. Check that password policy is respected.
  </details>

## Script

* ✅ written in bash
* ✅ no error visible
* <details>
  <summary> ✅ fires every 10 minutes </summary>
  `crontab -e` under root user
  </details>
* ✅ all required info shown
* ✅ broadcasted to all users
