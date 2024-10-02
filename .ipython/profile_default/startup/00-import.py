import sys
import os
from collections import defaultdict

try:
    import pandas as pd
except ImportError:
    print ("Not importing pandas - missing dependency")

try:
    import numpy as np
except ImportError:
    print ("Not importing numpy - missing dependency")

from itertools import *

def flatten(listOfLists):
    return list(chain.from_iterable(listOfLists))
