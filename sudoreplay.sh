set -x
sudoreplay -d /var/log/sudo -l fromdate "(who -b | awk '{print $3 ` ` $4}')"
set +x
