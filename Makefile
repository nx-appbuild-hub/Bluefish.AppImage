SOURCE="https://dl.bintray.com/probono/AppImages/Bluefish_Editor-2.2.10.glibc2.15-x86_64.AppImage"
OUTPUT="Bluefish.AppImage"

all:
	echo "Building: $(OUTPUT)"
	rm -f ./$(OUTPUT)
	wget --output-document=$(OUTPUT) --continue $(SOURCE)
	chmod +x $(OUTPUT)

