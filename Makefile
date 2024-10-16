TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard
THEOS_PACKAGE_SCHEME=rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = KasutamuRethought

KasutamuRethought_FILES = Tweak.x
KasutamuRethought_CFLAGS = -fobjc-arc -O3

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += KasutamuRethoughtPrefs
include $(THEOS_MAKE_PATH)/aggregate.mk
