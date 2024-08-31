# VisualBrake

**VisualBrake** es una herramienta para recordarte tomar descansos regulares y realizar ejercicios para tus ojos cada 20 minutos mientras trabajas frente a una pantalla.

<div align="center">
  <img src="https://github.com/user-attachments/assets/dd5c74f8-435d-44b8-90b1-8a3ea1aa3f79" />
</div>

## Instalación

Sigue los siguientes pasos para la Instalación:

### Requisitos

- Systemd (systemd-timers) o crontab.
- Bash y libnotify. 
- dunst, mako o cualquier otro demonio que use libnotify.

### Instalación 

Clona el repositorio de `VisualBrake`:

```bash
git clone https://github.com/vorosdev/VisualBrake.git
cd VisualBrake
./install.sh <opcion>
```

### Desintalacion o desactivar el servicio

Desactivar y parar el servicio

```bash
systemctl --user disable visual-break.timer
systemctl --user stop visual-break.timer
```

Para el `crontab` comentamos la linea:

`crontab -e`

```bash
# */20 * * * * /home/user/.local/bin/visual-break
```

Desinstalar la herramienta

```bash
rm ~/.local/bin/visual-break
rm ~/.config/systemd/user/visual-break.*
```
