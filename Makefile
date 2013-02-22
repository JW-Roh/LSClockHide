include theos/makefiles/common.mk

TWEAK_NAME = LSClockHide
LSClockHide_FILES = Tweak.xm
LSClockHide_FRAMEWORKS = UIKit Foundation

include $(THEOS_MAKE_PATH)/tweak.mk

export FW_DEVICE_IP=192.168.1.2

ri:: remoteinstall
remoteinstall:: all internal-remoteinstall after-remoteinstall
internal-remoteinstall::
	scp -P 22 "$(FW_PROJECT_DIR)/obj/$(TWEAK_NAME).dylib" root@$(FW_DEVICE_IP):
	scp -P 22 "$(FW_PROJECT_DIR)/$(TWEAK_NAME).plist" root@$(FW_DEVICE_IP):
	ssh root@$(FW_DEVICE_IP) "mv $(TWEAK_NAME).* /Library/MobileSubstrate/DynamicLibraries/"
after-remoteinstall::
	ssh root@$(FW_DEVICE_IP) "killall -9 SpringBoard"
