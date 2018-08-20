# Configuration file for ipython.

import os
import datetime as dt

c = get_config()

c.TerminalIPythonApp.display_banner = False
c.TerminalInteractiveShell.editor = 'nvim'
# Set to confirm when you try to exit IPython with an EOF (Control-D in Unix,
# Control-Z/Enter in Windows). By typing 'exit' or 'quit', you can force a
# direct exit without any confirmation.
c.TerminalInteractiveShell.confirm_exit = False

c.InteractiveShellApp.extensions = ['autoreload']
c.InteractiveShellApp.exec_lines = ['%autoreload 2']

#logfile_dir = os.path.expanduser('~/ipython-logs')
#if not os.path.exists(logfile_dir):
#    os.makedirs(logfile_dir)
#logfile_fn = os.path.join(logfile_dir,
#                          'automatic-log--%i.%02i.%02i--%02i.%02i.py' %
#                          dt.datetime.today().timetuple()[:5])
#with open(logfile_fn, 'w') as f:
#    pass
#c.TerminalInteractiveShell.logfile = logfile_fn
    

# Automatically call the pdb debugger after every exception.
# c.TerminalInteractiveShell.pdb = False
