cat << EOF > /etc/lightdm/lightdm.conf.d/autologin.conf
[Seat:*]
autologin-user=securityonion
EOF
