import 'package:blue_thermal_printer/blue_thermal_printer.dart';

class ReceiptPrinter {
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  void printReceipt(List<Map<String, dynamic>> items, double total) async {
    // Connect to the printer
    bool isConnected = await printer.isConnected ?? false;
    if (!isConnected) {
      List<BluetoothDevice> devices = await printer.getBondedDevices();
      // Assuming you have a bonded device named 'Thermal Printer'
      BluetoothDevice device = devices.firstWhere((device) => device.name == 'Thermal Printer');
      await printer.connect(device);
    }

    // Start printing
    printer.printNewLine();
    printer.printCustom("Receipt", 3, 1);
    printer.printNewLine();

    for (var item in items) {
      printer.printLeftRight(item['name'], '\$${item['price'].toStringAsFixed(2)}', 1);
    }

    printer.printNewLine();
    printer.printLeftRight("Total", '\$${total.toStringAsFixed(2)}', 1);
    printer.printNewLine();
    printer.printNewLine();
    printer.paperCut();
  }
}
