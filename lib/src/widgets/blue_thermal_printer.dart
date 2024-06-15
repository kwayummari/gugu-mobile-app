import 'package:blue_thermal_printer/blue_thermal_printer.dart';

class ReceiptPrinter {
  final BlueThermalPrinter _printer = BlueThermalPrinter.instance;

  Future<void> printReceipt(List<Map<String, dynamic>> items, double total) async {
    // Connect to the printer
    bool isConnected = await _printer.isConnected ?? false;
    if (!isConnected) {
      List<BluetoothDevice> devices = await _printer.getBondedDevices();
      // Check if the 'Thermal Printer' is among bonded devices
      try {
        BluetoothDevice device = devices.firstWhere((device) => device.name == 'Thermal Printer');
        await _printer.connect(device);
      } catch (e) {
        print("Error: Thermal Printer not found or failed to connect.");
        return;
      }
    }

    // Start printing
    _printer.printNewLine();
    _printer.printCustom("Receipt", 3, 1);
    _printer.printNewLine();

    for (var item in items) {
      _printer.printLeftRight(item['name'], '\$${item['price'].toStringAsFixed(2)}', 1);
    }

    _printer.printNewLine();
    _printer.printLeftRight("Total", '\$${total.toStringAsFixed(2)}', 1);
    _printer.printNewLine();
    _printer.printNewLine();
    _printer.paperCut();
  }
}
