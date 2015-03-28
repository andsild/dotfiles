dotfiles
========

Configuration files; pick as you please

# Current (active) setup:

## VIM
I use **Vim** a lot. The ideal goal is to have every package/program in vim. This is because everything I do on my computer is process information(text), 
and vim is my most efficient way of doing this.
The problem is that it is not easy to do everything in Vim, and I have to use other programs.  
Though, as my vim-foo increases, I'm slowly porting everything to the editor.

## WMII (Window / Tiling Manager)
An excellent tiling manager. There are no (silly) concepts of master windows
or fixed window rules. Even though some gurus claim that all you need is 4 applications and one shortcut to switch between each (minimalism = clear workflow), I still
find that I love the control I have in wmii.

## Gentoo / Portage (Package Management)
Oh boy, this takes time to setup. After a few months of usage, I'm finally at
the point that I understand how to fix build/emerge errors. I can't say that I
recommend this for everyone, but its wonderful if you have the time. Otherwise,
check out http://www.sabayon.org/

## st (simple-terminal) + Screen
I hated st for not implementing scrolling. 
Then I realized multiplexers (screen) are quite awesome.

`<C-A>[` will enable copy mode. When you learn to master this, you don't have
to use the mouse to copy paste, and you can quite easily search command output.
Of course, I'm still dreaming of a good vim-integration for shells rather than screen (some exist, but I feel inproductive).

## Zathura (PDF)
Because PDF (GUI) are prettier than `pdftotext` + vim.

## Chrome (Mail/Websites)
I wish I could I say I used some hardcore, customizable open-source client (...vim?)  
I've tinkered with UZBL quite a bit. But chrome is easy. All websites work.
I can synchronize settings to computers and devices *so easy*.


## Other (noteworthy mentions)

| Program     | Desc                                                                                                                                                  |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| `bitlbee`   | I'm not certain if I like it yet or not. Pidgin is so much easier, and bitlbee uses `perl`(yuck!).  |
| `cdm`       | A window manager (layman term: login manager). It doesn't use X, so if you mess up your X-settings/graphics driver, having a login without X is neat. |
| `gimp`      | I use it in general for cropping images.  Heavy, but OK. |
| `ipython`   | use this as your calculator |
| `mitmproxy` | excellent web interceptor |
| `slock`     | lock your computer |
| `spotify`   | Woopwoop |
| `sxiv`      | view images (or use `chrome`) |
| `xset`      | To disable screensaver: `xset -dpms; xset s off`. Stop using `xdotool` :p |
| `xrandr`    | Primarily I use it when connecting extra monitors. <br />`xrandr --auto LVDS1 --left-of VGA1`<br />is typical  usage (easily accessed with `<c-r>VGA` in a terminal. |
| `wpa_gui`   | Network-manager without too much hassle. |
| `workrave`  | prevent RSI and live healthily. Annoying as hell but a lifesaver. |

# License
I chose the most open one.  
https://help.github.com/articles/open-source-licensing/#what-happens-if-i-dont-choose-a-license
