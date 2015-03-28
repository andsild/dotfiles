import numpy as np
import scipy
from math import *

def abc(a,b,c):
    d = b**2-4*a*c # discriminant

    if d < 0:
        raise ValueError("No solution")
    elif d == 0:
        x1 = -b / (2*a)
        return x1, float("NaN")
    else: # if d > 0
        x1 = (-b + sqrt(d)) / (2*a)
        x2 = (-b - sqrt(d)) / (2*a)
        return x1, x2
