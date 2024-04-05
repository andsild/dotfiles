import sys
import os
from collections import defaultdict

try:
    import pandas
except ImportError:
    print ("Not importing pandas - missing dependency")

try:
    import numpy as np
except ImportError:
    print ("Not importing numpy - missing dependency")

try:
    import scipy
except ImportError:
    print ("Not importing scipy - missing dependency")

try:
    import torch
except ImportError:
    print ("Not importing torch - missing dependency")

try:
    import torch.nn.functional as F
except ImportError:
    print ("Not importing torch.nn.functional - missing dependency")

from itertools import *

def flatten(listOfLists):
    return list(chain.from_iterable(listOfLists))
