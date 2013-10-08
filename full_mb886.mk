#
# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# This file is the build configuration for a full Android
# build for mb886 hardware. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps). Except for a few implementation
# details, it only fundamentally contains two inherit-product
# lines, full and mb886, hence its name.
#

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

ifneq ($(TARGET_BUILD_VARIANT),codefirex)
# Get the long list of APNs
PRODUCT_COPY_FILES := device/sample/etc/apns-full-conf.xml:system/etc/apns-conf.xml

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)
else

## Specify phone tech before including full_phone
$(call inherit-product, vendor/cfx/config/gsm.mk)

# Boot animation
PRODUCT_COPY_FILES += \
    vendor/cfx/prebuilt/common/bootanimation/720.zip:system/media/bootanimation.zip

# Inherit some common CFX stuff.
$(call inherit-product, vendor/cfx/config/common_full_phone.mk)
endif

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := mb886
PRODUCT_NAME := full_mb886
PRODUCT_BRAND := motorola
PRODUCT_MODEL := MB886
PRODUCT_MANUFACTURER := motorola

# Inherit from hardware-specific part of the product configuration
$(call inherit-product, device/motorola/mb886/device_mb886.mk)
$(call inherit-product-if-exists, vendor/motorola/mb886/mb886-vendor.mk)
    
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_BRAND=motorola \
    PRODUCT_NAME=MB886_att \
    BUILD_PRODUCT=qinara \
    BUILD_FINGERPRINT=motorola/MB886_att/qinara:4.1.1/9.8.0Q-97_MB886_FFW-20/27:user/release-keys