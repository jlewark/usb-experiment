echo "Creating Device"
DIR=${PWD}
echo "$DIR"
modprobe libcomposite
mkdir -p cfg
mount none cfg -t configfs
mkdir -p cfg/usb_gadget/g1
cd cfg/usb_gadget/g1
mkdir -p configs/c.1
mkdir -p functions/hid.usb0
echo 1 > functions/hid.usb0/protocol
echo 1 > functions/hid.usb0/subclass
echo 8 > functions/hid.usb0/report_length
cat $DIR/keyboard_report_desc > functions/hid.usb0/report_desc
mkdir -p strings/0x409
mkdir -p configs/c.1/strings/0x409
echo "Creating Strings"
echo 0xa4ac > idProduct
echo 0x0525 > idVendor
echo serial > strings/0x409/serialnumber
echo manufacturer > strings/0x409/manufacturer
echo HID Gadget > strings/0x409/product
#echo "Conf 1" > configs/c.1/strings/0x409/configuration
#echo 120 > configs/c.1/MaxPower
echo "Creating Simlinks"
ln -s functions/hid.usb0 configs/c.1
echo musb-hdrc.0.auto > UDC

