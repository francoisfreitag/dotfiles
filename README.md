# dotfiles

```
uv run ansible-playbook setup.yaml
```

## usbguard

Needs manual configuration:
```
usbguard generate-policy >rules.conf
# Review generated rules.
sudo install -m 0600 -o root -g root rules.conf /etc/usbguard/rules.conf
sudo usbguard add-user -g wheel
sudo systemctl enable --now usbguard
```
