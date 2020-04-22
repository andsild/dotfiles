Normally, you would just use `/etc/nixos/configuration.nix`, however, since I use multiple computers, I need to have pluggable configs.

Here's how these files are used on my desktop computer:
```bash
$ ls -l /etc/nixos/  
total 12  
lrwxrwxrwx 1 root  44 Sep 13 10:57 configuration.nix -> /home/andesil/dotfiles/nixos/desktopHome.nix
-rw-r--r-- 1 root 675 Aug 11 20:33 hardware-configuration.nix  
-rw-r--r-- 1 root 220 Aug 14 12:03 hardware-setup-bigmomma.nix  
-rw-r--r-- 1 root  62 Aug 14 12:30 private.nix  
  
$ ls -l dotfiles/nixos/  
total 24  
-rw-r--r-- 1 andesil 9052 Jan  9 17:24 core.nix  
-rw-r--r-- 1 andesil  166 Aug 30 21:49 default.nix  
-rw-r--r-- 1 andesil  784 Jan  8 14:34 desktopHome.nix  
lrwxrwxrwx 1 root      37 Aug 30 21:59 hardware-configuration.nix -> /etc/nixos/hardware-configuration.nix
-rw-r--r-- 1 andesil  148 Sep 13 10:54 laptopWork.nix  
lrwxrwxrwx 1 root      22 Aug 30 21:59 private.nix -> /etc/nixos/private.nix  
-rw-r--r-- 1 andesil    0 Jan 13 11:56 readme.md  
```

The `hardware-configuration.nix` and `private.nix` are not in the repo, but have copies in this dotfiles repository. I do this to make local imports work.
