################################################################################
#
# simon-game
#
################################################################################

SIMON_GAME_VERSION = 1.0.1
SIMON_GAME_SITE = https://github.com/pauloserrafh/simon_python
SIMON_GAME_SITE_METHOD = git
SIMON_GAME_DEPENDENCIES = python-rpi-gpio

define SIMON_GAME_INSTALL_TARGET_CMDS
	rm -rf $(TARGET_DIR)/usr/local/bin/simon*
	mkdir -p $(TARGET_DIR)/usr/local/bin/
	cp -R $(@D) $(TARGET_DIR)/usr/local/bin/
endef

define SIMON_GAME_INSTALL_INIT_SCRIPT
	$(INSTALL) -D -m 0755 $(SIMON_GAME_PKGDIR)/S70simon $(TARGET_DIR)/etc/init.d/
endef

SIMON_GAME_POST_INSTALL_TARGET_HOOKS += SIMON_GAME_INSTALL_INIT_SCRIPT

$(eval $(generic-package))
