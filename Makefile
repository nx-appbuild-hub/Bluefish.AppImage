# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)


all: clean
	mkdir --parents $(PWD)/build

	wget --output-document=$(PWD)/build/Bluefish.AppImage --continue https://dl.bintray.com/probono/AppImages/Bluefish_Editor-2.2.10.glibc2.15-x86_64.AppImage
	chmod +x $(PWD)/build/Bluefish.AppImage

	cd $(PWD)/build && $(PWD)/build/Bluefish.AppImage --appimage-extract	

	wget --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/gtk2-2.24.32-4.el8.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/cairo-1.15.12-4.el7.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/libpng-1.5.13-8.el7.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	cp --force --recursive $(PWD)/build/usr/lib64/* $(PWD)/build/squashfs-root/usr/lib
	cp --force --recursive $(PWD)/build/usr/share/* $(PWD)/build/squashfs-root/usr/share

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/squashfs-root $(PWD)/Bluefish.AppImage
	chmod +x $(PWD)/Bluefish.AppImage

clean:
	rm -rf $(PWD)/build

