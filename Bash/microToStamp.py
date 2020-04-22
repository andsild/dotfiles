#!/usr/bin/env python
from datetime import datetime
import sys

print(datetime.fromtimestamp(float(sys.argv[1])).time().strftime('%H:%M:%S.%f')[:-3])
