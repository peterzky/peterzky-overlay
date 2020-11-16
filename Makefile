UPDATE_DIRS = files packages/go/v2ray

.PHONY: update
update: $(UPDATE_DIRS)

.PHONY: $(UPDATE_DIRS)
$(UPDATE_DIRS):
	$(MAKE) -C $@
