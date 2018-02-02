I've copied the config from user "skanev", see https://github.com/skanev/dotfiles/tree/master/mutt

# You need #TODO:
```bash
mkdir ~/.mail
ln -s ~/dotfiles/mutt/offlineimaprc ~/.offlineimap
ln -s ~/dotfiles/mutt/msmtprc ~/.msmtprc
echo source ~/.mutt/profiles/andsild > ~/.muttrc
ln -s ~/dotfiles/mutt/goobookrc.andsild ~/.goobookrc.andsild
notmuch setup # use absolute path for ~/.mail
notmuch new
```

### Notes
### Password protection
My setup is with gpg and two-factor authentication for gmail.
To setup gpg, simply type in:
```bash
gpg2 --gen-key
# (follow steps)
gpg2 --encrypt <file_with_app_password> -r <recipient>
mv <output from gpg2> ~/.offlineimappass.gpg
wipe <file_with_app_password>
```
[(wipe securely removes files)](http://wipe.sourceforge.net/)  
I recommend using an app password for gmail (it doesn't take long to setup) so you don't ever put your real password on disk or in your editor history.

### Finding SSL/TLS certificates
`gnutls-cli --print-cert HOSTNAME[:PORT] < /dev/null`
