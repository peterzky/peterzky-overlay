UPDATE_DIRS = files pkgs/go/v2ray pkgs/gfw-white-list

.PHONY: update $(UPDATE_DIRS)

update: $(UPDATE_DIRS)

$(UPDATE_DIRS):
	$(MAKE) -C $@
