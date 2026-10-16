#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# All components inherited here go to system image
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_system.mk)

# All components inherited here go to system_ext image
$(call inherit-product, $(SRC_TARGET_DIR)/product/handheld_system_ext.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony_system_ext.mk)

# All components inherited here go to product image
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_product.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# All components inherited here go to vendor image
$(call inherit-product, $(SRC_TARGET_DIR)/product/handheld_vendor.mk)
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# All components inherited here go to vendor image
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Add common definitions for Qualcomm
$(call soong_config_set,rfs,mpss_firmware_symlink_target,firmware_modem)
$(call inherit-product, hardware/qcom-caf/common/common.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit proprietary blobs
$(call inherit-product, vendor/samsung/sm7325-common/sm7325-common-vendor.mk)

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio.service \
    android.hardware.audio@7.0-impl.samsung-sm7325 \
    android.hardware.audio.effect@7.0-impl \
    android.hardware.bluetooth.audio-impl \
    android.hardware.soundtrigger@2.3-impl \
    aosp_audio_policy_volumes.xml \
    aosp_default_volume_tables.xml \
    aosp_r_submix_audio_policy_configuration.xml \
    audio.bluetooth.default \
    audio_effects.xml \
    audio_io_policy.conf \
    audio_platform_info.xml \
    audio_platform_info_intcodec.xml \
    audio_policy_configuration.xml \
    audio.r_submix.default \
    audio.usb.default \
    bluetooth_audio_policy_configuration_7_0.xml \
    libqcompostprocbundle \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    libqti_vndfwk_detect.vendor:32 \
    libsamsungSoundbooster_plus \
    libvolumelistener \
    mixer_usb_default.xml \
    privapp-permissions-hotword.xml \
    sound_trigger_mixer_paths.xml \
    sound_trigger_platform_info.xml \
    SamsungDAP \
    SoundBoosterStage

TARGET_EXCLUDES_AUDIOFX := true

$(call soong_config_set_bool,frameworks_av,use_aosp_audio_policy_volumes,true)
$(call soong_config_set_bool,frameworks_av,use_aosp_default_volume_tables,true)
$(call soong_config_set_bool,frameworks_av,use_aosp_r_submix_audio_policy_configuration,true)
$(call soong_config_set,samsungAudioVars,soundbooster_dsp_library,//vendor/samsung/sm7325-common:lib_SoundBooster_ver1050)

# Branding
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider-service.samsung

$(call soong_config_set_bool,samsungCameraVars,needs_sec_reserved_field,true)
$(call soong_config_set,samsungCameraVars,extra_ids,54) # ID=54 is macro

# Charger
PRODUCT_PACKAGES += \
    charger_res_images_vendor

# Display
PRODUCT_PACKAGES += \
    vendor.qti.hardware.display.composer-service \
    vendor.qti.hardware.display.allocator-service \
    android.hardware.graphics.mapper@3.0-impl-qti-display \
    android.hardware.graphics.mapper@4.0-impl-qti-display \
    vendor.qti.hardware.memtrack-service

# Display - Extra features
PRODUCT_PACKAGES += \
    vendor.lineage.livedisplay-service.samsung-qcom \
    vendor.lineage.touch-service.samsung

# Display - mDNIE
PRODUCT_PACKAGES += \
    AdvancedDisplay

# Doze
PRODUCT_PACKAGES += \
    SamsungDoze

# DRM - Clearkey
PRODUCT_PACKAGES += \
    android.hardware.drm-service.clearkey

# Fastboot
PRODUCT_PACKAGES += \
    fastbootd

TARGET_BOARD_FASTBOOT_INFO_FILE := $(LOCAL_PATH)/configs/fastboot/fastboot-info.txt

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint-service.samsung

# FlipFlap
PRODUCT_PACKAGES += \
    FlipFlap

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper-service.samsung

# General
PRODUCT_PACKAGES += \
    vndservicemanager

# GMS
PRODUCT_GMS_CLIENTID_BASE := android-samsung

# Health - Lineage
PRODUCT_PACKAGES += \
    vendor.lineage.health-service.default

$(call soong_config_set,lineage_health,charging_control_charging_disabled,1)
$(call soong_config_set,lineage_health,charging_control_charging_enabled,0)
$(call soong_config_set,lineage_health,charging_control_charging_path,/sys/class/power_supply/battery/batt_slate_mode)
$(call soong_config_set,lineage_health,fast_charge_node,/sys/class/sec/switch/afc_disable)
$(call soong_config_set,lineage_health,fast_charge_value_fast_charge,0)
$(call soong_config_set,lineage_health,fast_charge_value_none,1)
$(call soong_config_set_bool,lineage_health,charging_control_supports_bypass,false)

# Health - Samsung
PRODUCT_PACKAGES += \
    android.hardware.health-service.samsung \
    android.hardware.health-service.samsung-recovery

# ION
$(call soong_config_set_bool,libion,legacy_impl,true)

# Init
PRODUCT_PACKAGES += \
    fstab.ramplus \
    init.audio.samsung.rc \
    init.fingerprint.rc \
    init.nfc.samsung.rc \
    init.qcom.rc \
    init.qcom.recovery.rc \
    init.qti.kernel.rc \
    init.qti.media.rc \
    init.ramplus.rc \
    init.samsung.bsp.rc \
    init.samsung.display.rc \
    init.samsung.rc \
    init.target.rc \
    init.vendor.onebinary.rc \
    init.vendor.rilcommon.rc \
    init.vendor.sensors.rc \
    ueventd.qcom.rc \
    vendor.samsung.rilchip.qcom.rc \
    wifi_qcom_wcn6750.rc \
    wifi_sec.rc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/init/fstab.qcom:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.qcom \
    $(LOCAL_PATH)/configs/init/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom

$(call soong_config_set,libinit,vendor_init_lib,//$(LOCAL_PATH):libinit_samsung_sm7325)

# Init - Shell scripts
PRODUCT_PACKAGES += \
    init.class_main.sh \
    init.kernel.post_boot-yupik.sh \
    init.kernel.post_boot.sh \
    init.qcom.class_core.sh \
    init.qcom.early_boot.sh \
    init.qcom.post_boot.sh \
    init.qcom.sh \
    init.qti.chg_policy.sh \
    init.qti.display_boot.rc \
    init.qti.display_boot.sh \
    init.qti.kernel.sh \
    init.qti.media.sh \
    init.qti.qcv.sh \
    vendor_modprobe.sh

# Keylayout
PRODUCT_PACKAGES += \
    sec_touchscreen.kl

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.0-service.samsung

$(call soong_config_set,samsungVars,target_keymaster4_library,//vendor/samsung/sm7325-common:libskeymaster4device)

# Overlays
PRODUCT_PACKAGES += \
    ApertureOverlayCommon \
    FlipFlapOverlayCommon \
    FrameworkResOverlayCommon \
    Launcher3QuickstepOverlayCommon \
    LineagePartsOverlayCommon \
    LineageSDKOverlayCommon \
    SettingsOverlayCommon \
    SystemUIOverlayCommon \
    WiFiOverlayCommon

PRODUCT_ENFORCE_RRO_TARGETS := *

# Media - Configuration
PRODUCT_PACKAGES += \
    media_codecs_lahaina_vendor.xml \
    media_codecs_lahaina.xml \
    media_codecs_performance_lahaina_vendor.xml \
    media_codecs_performance_lahaina.xml \
    media_codecs_performance_yupik_iot.xml \
    media_codecs_performance_yupik_v0.xml \
    media_codecs_performance_yupik_v1.xml \
    media_codecs_yupik_iot.xml \
    media_codecs_yupik_v0.xml \
    media_codecs_yupik_v1.xml \
    media_profiles_lahaina_vendor.xml \
    media_profiles_lahaina.xml \
    media_profiles_V1_0.xml \
    media_profiles_vendor.xml \
    media_profiles.xml \
    media_profiles_yupik_iot.xml \
    media_profiles_yupik_v0.xml \
    media_profiles_yupik_v1.xml

# NFC
PRODUCT_PACKAGES += \
    libnfc-nci.conf

ifeq ($(TARGET_HAVE_SEC_NFC),true)
PRODUCT_PACKAGES += \
    android.hardware.nfc-service.sec \
    libnfc-sec-vendor.conf
endif

# Partitions - Dynamic
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Partitions - Symlinks
PRODUCT_PACKAGES += \
    vendor_dsp_mountpoint \
    vendor_firmware-modem_mountpoint \
    vendor_firmware_mnt_mountpoint

# Partitions - Updater
AB_OTA_UPDATER := false

# Permissions
PRODUCT_PACKAGES += \
    android.hardware.audio.low_latency.prebuilt.xml \
    android.hardware.bluetooth.prebuilt.xml \
    android.hardware.bluetooth_le.prebuilt.xml \
    android.hardware.camera.flash-autofocus.prebuilt.xml \
    android.hardware.camera.front.prebuilt.xml \
    android.hardware.camera.full.prebuilt.xml \
    android.hardware.camera.raw.prebuilt.xml \
    android.hardware.fingerprint.prebuilt.xml \
    android.hardware.location.gps.prebuilt.xml \
    android.hardware.nfc.hce.prebuilt.xml \
    android.hardware.nfc.hcef.prebuilt.xml \
    android.hardware.nfc.prebuilt.xml \
    android.hardware.sensor.accelerometer.prebuilt.xml \
    android.hardware.sensor.compass.prebuilt.xml \
    android.hardware.sensor.gyroscope.prebuilt.xml \
    android.hardware.sensor.light.prebuilt.xml \
    android.hardware.sensor.proximity.prebuilt.xml \
    android.hardware.sensor.stepcounter.prebuilt.xml \
    android.hardware.sensor.stepdetector.prebuilt.xml \
    android.hardware.telephony.gsm.prebuilt.xml \
    android.hardware.usb.accessory.prebuilt.xml \
    android.hardware.usb.host.prebuilt.xml \
    android.hardware.vulkan.compute-0.prebuilt.xml \
    android.hardware.vulkan.level-1.prebuilt.xml \
    android.hardware.wifi.direct.prebuilt.xml \
    android.hardware.wifi.passpoint.prebuilt.xml \
    android.hardware.wifi.prebuilt.xml \
    android.software.ipsec_tunnels.prebuilt.xml \
    android.software.sip.voip.prebuilt.xml \
    android.software.verified_boot.prebuilt.xml \
    com.nxp.mifare.prebuilt.xml \
    handheld_core_hardware.prebuilt.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.pro.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.pro.xml \
    frameworks/native/data/etc/android.hardware.nfc.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.uicc.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version-1_1.xml \
    frameworks/native/data/etc/android.hardware.wifi.aware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.aware.xml \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.freeform_window_management.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2020-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.deqp.level.xml

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-service.pixel-libperfmgr \
    powerhint.json

# RIL
PRODUCT_PACKAGES += \
    secril_config_svc \
    sehradiomanager

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors-service.samsung-multihal

# Soong Namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    bootable/deprecated-ota \
    hardware/google/interfaces \
    hardware/google/pixel/power-libperfmgr \
    hardware/samsung \
    vendor/qcom/opensource/usb/etc

# Task profiles
PRODUCT_PACKAGES += \
    task_profiles.json.sm7325

# Tether
PRODUCT_PACKAGES += \
    ipacm \
    IPACM_cfg.xml

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb-service.qti \
    init.qcom.usb.rc \
    init.qcom.usb.sh

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator-service.samsung

$(call soong_config_set_bool,samsungVibratorVars,duration_amplitude,true)

# Wi-Fi
PRODUCT_PACKAGES += \
    WCNSS_qcom_cfg.ini \
    android.hardware.wifi-service \
    hostapd \
    icm.conf \
    indoorchannel.info \
    libwifi-hal-qcom \
    libwpa_client \
    p2p_supplicant_overlay.conf \
    wpa_cli \
    wpa_supplicant \
    wpa_supplicant.conf \
    wpa_supplicant_overlay.conf

# Wi-Fi - Firmware - Symlinks
PRODUCT_PACKAGES += \
    firmware_qca6750_WCNSS_qcom_cfg.ini_symlink \
    firmware_wlan_WCNSS_qcom_cfg.ini_symlink
