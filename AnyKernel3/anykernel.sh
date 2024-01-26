	1	# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Sudah Backup BOOT dan DTBO
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=alioth
device.name2=aliothin
device.name3=
device.name4=
device.name5=
supported.versions=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=1;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

case "$ZIPFILE" in
    *miui*)
    ui_print " ==============================";
    ui_print "    Stock Based Rom detected ";
    ui_print " ";
    ui_print "    Auto Removed dtb and dtbo ";
    ui_print " ==============================";
    rm dtb;
    rm dtbo.img;
    ;;
    *)
    ui_print " ==============================";
    ui_print " ";
    ui_print "    AOSP Based rom detected  ";
    ui_print " ";
    ui_print " ==============================";
    ;;
esac

## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 750 750 $ramdisk/*;


## AnyKernel install
dump_boot;
flash_dtbo

# Begin Ramdisk Changes

# migrate from /overlay to /overlay.d to enable SAR Magisk
if [ -d $ramdisk/overlay ]; then
  rm -rf $ramdisk/overlay;
fi;

write_boot;
## end install

