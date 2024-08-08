

import 'package:esc_pos_dart/esc_pos_printer.dart';
import 'package:esc_pos_dart/esc_pos_utils.dart';
import 'package:intl/intl.dart';
import 'package:printing_pos/models/comptoire_model.dart';

final NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
class ComptoireOrder {


Future<bool> printStock(ComptoireOrderModel orderModel, List<OrderProduct> products) async{

  var profile = await CapabilityProfile.load();
  final generator = NetworkPrinter(PaperSize.mm80, profile);
  await generator.connect("172.20.100.152", port: 9100);

  await generator.ensureConnected();

  generator.text("Comptoire",
            styles: const PosStyles(bold: true));
        generator.text("Heure : ${orderModel.order_time}");
        generator.text("Responsable : ${orderModel.responsable}");
        generator.text("No. ${orderModel.cmd_code == null ? ' P.' : 'C.'}:${orderModel.cmd_code ?? orderModel.proforma_code} ",styles:
                  const PosStyles(codeTable: 'CP1252', align: PosAlign.right,bold: true));
  for (var prod in products) {
       generator.hr();
        generator.text(prod.toString(),styles:
                  const PosStyles(codeTable: 'CP1252', align: PosAlign.left));
        generator.text("Qts: ${myFormat.format(prod.product_qty)}", styles:
                  const PosStyles(codeTable: 'CP1252', align: PosAlign.right));

         generator.hr();
   }
       
  generator.feed(1);
   generator.reset();
    generator.beep(n: 3);
    generator.feed(1);
    generator.cut();

  generator.endJob();

    generator.disconnect(delayMs: 300);
    return true;
  }

}