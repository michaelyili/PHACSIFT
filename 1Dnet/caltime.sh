#!/bin/sh

sh ~/HSPICE/gensrc/1Dnet/gennetlist_cap -r 1000 -s 4096
sh spectre -outdir ./spectredata resnet.sp
mv spectredata/resnet.print spectredata/resnet_4096_1000.print

sh ~/HSPICE/gensrc/1Dnet/gennetlist_cap -r 5000 -s 4096
sh spectre -outdir ./spectredata resnet.sp
mv spectredata/resnet.print spectredata/resnet_4096_5000.print

sh ~/HSPICE/gensrc/1Dnet/gennetlist_cap -r 10000 -s 4096
sh spectre -outdir ./spectredata resnet.sp
mv spectredata/resnet.print spectredata/resnet_4096_10000.print

sh ~/HSPICE/gensrc/1Dnet/gennetlist_cap -r 20000 -s 4096
sh spectre -outdir ./spectredata resnet.sp
mv spectredata/resnet.print spectredata/resnet_4096_20000.print

sh ~/HSPICE/gensrc/1Dnet/gennetlist_cap -r 25000 -s 4096
sh spectre -outdir ./spectredata resnet.sp
mv spectredata/resnet.print spectredata/resnet_4096_25000.print

sh ~/HSPICE/gensrc/1Dnet/gennetlist_cap -r 1000 -s 16384
sh spectre -outdir ./spectredata resnet.sp
mv spectredata/resnet.print spectredata/resnet_16384_1000.print

sh ~/HSPICE/gensrc/1Dnet/gennetlist_cap -r 5000 -s 16384
sh spectre -outdir ./spectredata resnet.sp
mv spectredata/resnet.print spectredata/resnet_16384_5000.print

sh ~/HSPICE/gensrc/1Dnet/gennetlist_cap -r 10000 -s 16384
sh spectre -outdir ./spectredata resnet.sp
mv spectredata/resnet.print spectredata/resnet_16384_10000.print

sh ~/HSPICE/gensrc/1Dnet/gennetlist_cap -r 20000 -s 16384
sh spectre -outdir ./spectredata resnet.sp
mv spectredata/resnet.print spectredata/resnet_16384_20000.print

sh ~/HSPICE/gensrc/1Dnet/gennetlist_cap -r 25000 -s 16384
sh spectre -outdir ./spectredata resnet.sp
mv spectredata/resnet.print spectredata/resnet_16384_25000.print

sh ~/HSPICE/gensrc/1Dnet/gennetlist_cap -r 1000 -s 65536
sh spectre -outdir ./spectredata resnet.sp
mv spectredata/resnet.print spectredata/resnet_65536_1000.print

sh ~/HSPICE/gensrc/1Dnet/gennetlist_cap -r 5000 -s 65536
sh spectre -outdir ./spectredata resnet.sp
mv spectredata/resnet.print spectredata/resnet_65536_5000.print

sh ~/HSPICE/gensrc/1Dnet/gennetlist_cap -r 10000 -s 65536
sh spectre -outdir ./spectredata resnet.sp
mv spectredata/resnet.print spectredata/resnet_65536_10000.print

sh ~/HSPICE/gensrc/1Dnet/gennetlist_cap -r 20000 -s 65536
sh spectre -outdir ./spectredata resnet.sp
mv spectredata/resnet.print spectredata/resnet_65536_20000.print

sh ~/HSPICE/gensrc/1Dnet/gennetlist_cap -r 25000 -s 65536
sh spectre -outdir ./spectredata resnet.sp
mv spectredata/resnet.print spectredata/resnet_65536_25000.print
