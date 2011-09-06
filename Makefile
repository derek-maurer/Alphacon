include theos/makefiles/common.mk

TWEAK_NAME = Alphacon
Alphacon_FILES = Tweak.xm
Alphacon_FRAMEWORKS = UIKit
SUBPROJECTS = alphaconsettings
include $(THEOS_MAKE_PATH)/aggregate.mk
include $(THEOS_MAKE_PATH)/tweak.mk