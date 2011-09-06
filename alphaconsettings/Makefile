include theos/makefiles/common.mk

BUNDLE_NAME = alphacon
alphacon_FILES = alphacon.mm
alphacon_INSTALL_PATH = /Library/PreferenceBundles
alphacon_FRAMEWORKS = UIKit
alphacon_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/alphacon.plist$(ECHO_END)
