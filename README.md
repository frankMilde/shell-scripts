shell-scripts
=============

This repository includes some useful shell scripts to set up systems and
ease the use with various command line tools.

To use some of the script system wide, some automatic symlinks to
`~/local/bin` can be created using `stow`. In this directory run:
```
$stow startup
Loading defaults from .stowrc
LINK: startup-git-pulls.sh =>
../../github/shell-scripts/startup/startup-git-pulls.sh
LINK: startup-gpg-agent.sh =>
../../github/shell-scripts/startup/startup-gpg-agent.sh
LINK: startup-check-pacman-updates.sh =>
../../github/shell-scripts/startup/startup-check-pacman-updates.sh
```
