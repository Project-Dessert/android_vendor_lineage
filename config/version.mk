PRODUCT_VERSION_MAJOR = 12L
PRODUCT_VERSION_CODENAME = CUPCAKE-WIP


# Vanilla
ifeq ($(RELEASE_BUILDTYPE), OFFICIAL)
    RELEASE_TYPE = -OFFICIAL
    ifeq ($(GAPPS),)
        PRODUCT_PROPERTY_OVERRIDES += lineage.updater.uri=https://github.com/Project-Sweets/ota_config/raw/snowcone/{device}.json
    endif
else
    RELEASE_TYPE = UNOFFICIAL
endif
PRODUCT_SWEET_EXTRAVERSION = VANILLA-

# Chocolate
ifeq ($(GAPPS),true)
    $(GAPPS will be included in the build)
    PRODUCT_SWEET_EXTRAVERSION = CHOCOLATE-
    ifeq ($(RELEASE_TYPE),OFFICIAL)
        PRODUCT_PROPERTY_OVERRIDES += lineage.updater.uri=https://github.com/Project-Sweets/ota_config/raw/snowcone_g/{device}.json
    endif
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
LINEAGE_VERSION := $(PRODUCT_VERSION_MAJOR)-$(PRODUCT_VERSION_CODENAME)-$(PRODUCT_SWEET_EXTRAVERSION)$(shell date -u +%Y%m%d)-$(LINEAGE_BUILD)$(RELEASE_TYPE)
LINEAGE_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR)-$(PRODUCT_VERSION_CODENAME)-$(PRODUCT_SWEET_EXTRAVERSION)$(shell date -u +%Y%m%d)-$(LINEAGE_BUILD)$(RELEASE_TYPE)
