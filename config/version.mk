PRODUCT_VERSION_MAJOR = Donut
PRODUCT_VERSION_MINOR = Feb

ifeq ($(LINEAGE_VERSION_APPEND_TIME_OF_DAY),true)
    LINEAGE_BUILD_DATE := $(shell date -u +%Y%m%d_%H%M%S)
else
    LINEAGE_BUILD_DATE := $(shell date -u +%Y%m%d)
endif

# Vanilla
ifeq ($(GAPPS),)
    PRODUCT_PROPERTY_OVERRIDES += lineage.updater.uri=https://github.com/Project-Sweets/ota_config/raw/snowcone/{device}.json
    WITH_GMS := true
    SWEET_EXTRAVERSION = VANILLA-
endif

# Chocolate
ifeq ($(GAPPS),true)
    $(GAPPS will be included in the build)
    SWEET_EXTRAVERSION = CHOCOLATE-
    PRODUCT_PROPERTY_OVERRIDES += lineage.updater.uri=https://github.com/Project-Sweets/ota_config/raw/snowcone_g/{device}.json
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

# Set LINEAGE_BUILDTYPE from the env RELEASE_TYPE, for jenkins compat

LINEAGE_VERSION_SUFFIX := $(LINEAGE_BUILD_DATE)-$(SWEET_EXTRAVERSION)-$(LINEAGE_BUILD)

# Internal version
LINEAGE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(LINEAGE_VERSION_SUFFIX)

# Display version
LINEAGE_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR)-$(LINEAGE_VERSION_SUFFIX)
