UPDATE_DIRS = files pkgs/gfw-white-list

.PHONY: update $(UPDATE_DIRS)

update: $(UPDATE_DIRS)

$(UPDATE_DIRS):
	$(MAKE) -C $@
