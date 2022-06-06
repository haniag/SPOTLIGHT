TARGET = iphone:clang::10.0

ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ULSPOTLIGT
ULSPOTLIGT_FILES = Tweak.xm
ULSPOTLIGT_FRAMEWORKS = IOKit
ULSPOTLIGT_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
