VERSION=0.6.1
./configure
make clean
rm -f build_stamp
rm -f config.log
cd ..
cp -r wput wput-$VERSION
find wput-$VERSION -name .svn | xargs rm -r
tar czvf wput-$VERSION.tgz --exclude releasewput.sh wput/
cd wput-$VERSION
make
#fakeroot debian/rules binary
./wput ftp://upload.sourceforge.net/incoming/ ../wput*.tgz --basename ../
cd ..
rm -r wput-$VERSION*
