PRODUCT_VERSION_MAJOR := 12L
PRODUCT_VERSION_CODENAME = CUPCAKE-WIP


# Vanilla
ifeq ($(GAPPS),)
    PRODUCT_PROPERTY_OVERRIDES += lineage.updater.uri=https://github.com/Project-Dessert/ota_config/raw/snowcone/{device}.json
    WITH_GMS := true
    PRODUCT_DESSERT_EXTRAVERSION = VANILLA-
else

# Chocolate
ifeq ($(GAPPS),true)
    $(GAPPS will be included in the build)
    PRODUCT_DESSERT_EXTRAVERSION = CHOCOLATE-
    PRODUCT_PROPERTY_OVERRIDES += lineage.updater.uri=https://github.com/Project-Dessert/ota_config/raw/snowcone_g/{device}.json
    ifeq ($(GAPPS_ARM32),)
        $(warning GAPPS_ARM32 is not set, it defaulting to 64 bit)
        $(warning Dont try to set it, only needed for 32 bit devices)
        $(call inherit-product, vendor/gapps/arm64/arm64-vendor.mk)
    endif
    ifeq ($(GAPPS_ARM32), false)
        $(warning including 32 bit gapps)
        $(call inherit-product, vendor/gapps/arm/arm-vendor.mk)
    endif
endif


# Display version
LINEAGE_VERSION := $(PRODUCT_VERSION_MAJOR)-$(PRODUCT_VERSION_CODENAME)-$(PRODUCT_DESSERT_EXTRAVERSION)$(shell date -u +%Y%m%d)-$(LINEAGE_BUILD)
LINEAGE_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR)-$(PRODUCT_VERSION_CODENAME)-$(PRODUCT_DESSERT_EXTRAVERSION)$(shell date -u +%Y%m%d)-$(LINEAGE_BUILD)
