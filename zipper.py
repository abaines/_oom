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


extensions = [".toc",".xml",".lua"]

folders_start_with = "_"

rootx = os.path.dirname(os.path.abspath(__file__))
print( 'rootx', rootx )


def getAllFiles(directory):
   returns = []
   for path, subdirs, files in os.walk(directory):
      for name in files:
         f = os.path.join(path, name)
         p = os.path.relpath(f, start=directory)
         returns.append(p)
   return returns

def filterStartingFolder(directories, startsWith, extensions):
   def l(p):
      if not p.startswith(startsWith):
         return False

      for extension in extensions:
         if p.endswith(extension):
            return True
      
      return False
      

   new_list = filter(l,directories)

   return list(new_list)

all_files = getAllFiles(rootx)


mod_files = filterStartingFolder(all_files,folders_start_with,extensions)
print(mod_files)

with zipfile.ZipFile("_oom.zip", 'w') as zout:
   for f in mod_files:
      print("./"+f,f)
      zout.write("./"+f,f)

