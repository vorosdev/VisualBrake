# VisualBrake

[**VisualBrake**](https://github.com/vorosdev/VisualBrake) is a tool that reminds you to take 
regular breaks and perform eye exercises every 20 minutes while you work in front of a screen.

<div align="center">
  <img src="https://github.com/user-attachments/assets/dd5c74f8-435d-44b8-90b1-8a3ea1aa3f79" />
</div>

# Installation

Follow these steps for installation:

Requirements

- Systemd (systemd-timers)
- Bash 
- libnotify
- Notification daemon (e.g., dunst or mako)

These requirements typically come pre-installed with the distribution.

### Installation 

Clone the repository:

```bash
git clone https://github.com/vorosdev/VisualBrake.git
cd VisualBrake
./install.sh systemd
```

### Uninstallation or Disabling the Service

Disable and stop the service:

```bash
systemctl --user disable visual-break.timer
systemctl --user stop visual-break.timer
```

Uninstall the tool:

```bash
rm ~/.local/bin/visual-break
rm ~/.config/systemd/user/visual-break.*
```
