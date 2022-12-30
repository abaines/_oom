# Alan Baines

import os.path
import os
import threading
import hashlib
import shutil
import time
import glob
import re
import zipfile
import datetime
import tempfile
import sys
import traceback
import json


rootx = os.path.dirname(os.path.abspath(__file__))
print( 'rootx', rootx )

baseFolder = rootx[:rootx.rindex(os.sep)+1]
print( 'baseFolder', baseFolder )


def getAllFiles(directory):
   returns = []
   for path, subdirs, files in os.walk(directory):
      for name in files:
         f = os.path.join(path, name)
         returns.append(f)
   return returns

def endsWithAny(text,collection):
   for c in collection:
      if text.endswith(c):
         return c
   return False


# check os.name to determine interactive mode
if os.name == 'nt':
   input("Press Enter to continue...")
elif os.name == 'posix':
   print( os.listdir(os.pardir) )
else:
   raise Exception("unknown os.name",os.name)

