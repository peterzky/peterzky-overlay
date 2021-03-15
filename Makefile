UPDATE_DIRS = files packages/go/v2ray packages/gfw-white-list

.PHONY: update $(UPDATE_DIRS)

update: $(UPDATE_DIRS)

$(UPDATE_DIRS):
	$(MAKE) -C $@
