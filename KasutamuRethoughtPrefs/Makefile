TARGET := iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = KasutamuRethoughtPrefs

KasutamuRethoughtPrefs_FILES = KSTRootListController.m
KasutamuRethoughtPrefs_FRAMEWORKS = UIKit
KasutamuRethoughtPrefs_PRIVATE_FRAMEWORKS = Preferences
KasutamuRethoughtPrefs_INSTALL_PATH = /Library/PreferenceBundles
KasutamuRethoughtPrefs_CFLAGS = -fobjc-arc -O3

include $(THEOS_MAKE_PATH)/bundle.mk
