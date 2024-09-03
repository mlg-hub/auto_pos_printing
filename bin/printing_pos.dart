import 'dart:convert';

import 'package:printing_pos/api/comptoire_order.dart';
import 'package:printing_pos/models/comptoire_model.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

// void main(List<String> arguments) {
//   print('Hello world: ${printing.calculate()}!');
// }

Future<void> main() async {
  var app = Router();

  app.post('/print_comptoire_order', (Request request) async {
    final payload = await request.readAsString();
    final data = json.decode(payload) as Map<String, dynamic>;
    final order_model = ComptoireOrderModel.fromJson(data);
    final List<dynamic> list = data["products"];
    final List<OrderProduct> products = list.map((e) => OrderProduct.fromJson(e)).toList();

    print(order_model.cmd_code);
    print(order_model.proforma_code);
    print(products);
    print(order_model);

    final savedPdf = await ComptoireOrder().printStock(order_model,products);
    return Response.ok(json.encode(savedPdf ? "printed" : "failed"));
  });



  app.get('/user/<user>', (Request request, String user) {
    return Response.ok('hello $user');
  });

  print("...THE SERVER ABOUT TO START...");

  await io.serve(app.call, '127.0.0.1', 5500);

  // printing.printAchats();
}