#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2025 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'device/samsung/sm7325-common',
    'hardware/qcom-caf/sm8350',
    'hardware/qcom-caf/wlan',
    'hardware/samsung',
    'vendor/qcom/opensource/dataservices',
    'vendor/qcom/opensource/display',
]


lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
}

blob_fixups: blob_fixups_user_type = {
    'vendor/lib64/libsec-ril-impl.so': blob_fixup()
        .binary_regex_replace(b'ril.dds.call.ongoing', b'vendor.calls.slot_id')
        # Always emit uiccApplicationsEnablementChanged
        # Before: [b.lt 0x003e5cdc]
        # After: [nop]
        .sig_replace('1f 00 08 6b ab 01 00 54', '1f 00 08 6b 1f 20 03 d5')
        # Before: [b.lt 0x003ee460]
        # After: [nop]
        .sig_replace('ff 02 08 6b ab 01 00 54', 'ff 02 08 6b 1f 20 03 d5')
        # Skip legacy UICC code
        # Before: [b.ge 0x0066e5bc]
        # After: [b 0x0066e5bc]
        .sig_replace('1f 00 08 6b aa 02 00 54', '1f 00 08 6b 15 00 00 14')
        # Before: [b.gt 0x003ee664]
        # After: [b 0x003ee664]
        .sig_replace('1f 00 08 6b 0c 01 00 54', '1f 00 08 6b 08 00 00 14'),
    ('vendor/lib64/hw/gatekeeper.mdfpp.so', 'vendor/lib64/libkeymaster_helper.so', 'vendor/lib64/libskeymaster4device.so'): blob_fixup()
        .replace_needed('libcrypto.so', 'libcrypto-v33.so'),
    ('vendor/lib/libdpps.so', 'vendor/lib64/libdpps.so', 'vendor/lib/libsnapdragoncolor-manager.so', 'vendor/lib64/libsnapdragoncolor-manager.so'): blob_fixup()
        .replace_needed('libtinyxml2.so', 'libtinyxml2-v34.so'),
    ('vendor/lib/libwvhidl.so', 'vendor/lib/mediadrm/libwvdrmengine.so', 'vendor/lib64/libwvhidl.so', 'vendor/lib64/mediadrm/libwvdrmengine.so'): blob_fixup()
        .add_needed('libcrypto_shim.so'),
    'vendor/lib64/unihal_main@2.15.so': blob_fixup().add_needed('libui_shim.so'),
}  # fmt: skip

module = ExtractUtilsModule(
    'sm7325-common',
    'samsung',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
)

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
