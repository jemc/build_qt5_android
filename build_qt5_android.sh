
# A script for downloading and building the tools for qt5 android development.
# Your configuration needs may vary, so use it as a reference only.

# Adapted from the following post on Stack Overflow:
#   http://stackoverflow.com/questions/16313314/how-to-build-qt5-for-android

PATH=/opt/qt5-android

GROUP=`groups $USER | awk '{print($3)}'`


# Make and change to the proper directory
sudo mkdir $PATH
sudo chown $USER:$GROUP $PATH -R
cd $PATH

# Download and update the Android SDK
wget http://dl.google.com/android/android-sdk_r21.1-linux.tgz
tar -xf android-sdk_r21.1-linux.tgz
android-sdk-linux/tools/android update sdk --no-ui


# Download the 32-bit Android NDK
#wget http://dl.google.com/android/ndk/android-ndk-r8e-linux-x86.tar.bz2
#tar -xf android-ndk-r8e-linux-x86.tar.bz2

# Download the 64-bit Android NDK
wget http://dl.google.com/android/ndk/android-ndk-r8e-linux-x86_64.tar.bz2
tar -xf android-ndk-r8e-linux-x86_64.tar.bz2


# Download and update the qt5 repository
git clone git://gitorious.org/qt/qt5.git qt5
cd qt5
perl init-repository --no-webkit

# Configure and make qt5
./configure \
    -developer-build -platform linux-g++-64 \
    -xplatform android-g++ \
    -nomake tests \
    -nomake examples \
    -android-ndk /opt/qt5-android/android-ndk-r8e \
    -android-sdk /opt/qt5-android/android-sdk-linux \
    -skip qttools \
    -skip qttranslations \
    -skip qtwebkit \
    -skip qtserialport \
    -android-ndk-host linux-x86_64 \
    -android-toolchain-version 4.4.3
make


