JETIX=../jetix generate-sdk
PWD=$(shell pwd)
EXOTEL_SDK_PATH := $(PWD)/exotel-voice-sdk
EXOTEL_SDK_VERSION := 1.0.44
GIT_URL := https://github.com/exotel/exotel-voip-sdk-android/releases/download/$(EXOTEL_SDK_VERSION)/exotel-voice-$(EXOTEL_SDK_VERSION)-release.aar
EXOTEL_SDK_FILE := exotel-voice-$(EXOTEL_SDK_VERSION)-release.aar

deps:
	rm -rf $(EXOTEL_SDK_PATH)/exotel-voice-release.aar
	curl -L $(GIT_URL) -o $(EXOTEL_SDK_PATH)/exotel-voice-release.aar


