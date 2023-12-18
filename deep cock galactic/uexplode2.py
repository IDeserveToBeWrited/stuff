#!/usr/bin/env python3

import sys, os, errno

def mkdir_p(path):
    try:
        os.makedirs(path)
    except OSError as exc:
        if exc.errno == errno.EEXIST and os.path.isdir(path):
            pass
        else:
            raise

def analyze(file):
    magics = {
        'ogg': b'OggS',
        'wav': b'RIFF'
    }
    start = file.read(1024)
    for ftype, magic in magics.items():
        loc = start.find(magic)
        if loc != -1:
            return (ftype, loc)
    return None

if __name__ == '__main__':
    if len(sys.argv) <= 2:
        sys.exit("Usage: uexplode.py <input dir> <output dir>")

    if not os.path.exists(sys.argv[1]):
        sys.exit("Input dir does not exist")

    indir = sys.argv[1]
    outdir = sys.argv[2]
    
    for root, dirs, files in os.walk(indir, topdown=True):
        destdir = os.path.join(outdir, root[len(indir)+1:])
        for name in files:
            if name.endswith('.uexp'):
                with open(os.path.join(root, name), 'rb') as f:
                    anl = analyze(f)
                    if anl is not None:
                        destfname = name[:-5] + '.' + anl[0]
                        destpath = os.path.join(destdir, destfname)
                        mkdir_p(destdir)
                        with open(destpath, 'wb') as dest:
                            f.seek(anl[1])
                            dest.write(f.read())
                        print('{} -> {}'.format(os.path.join(root, name), destpath))