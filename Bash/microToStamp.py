#!/usr/bin/env python
from datetime import datetime
import sys

print(datetime.fromtimestamp(long(sys.argv[1])).time())
