

// ignore_for_file: non_constant_identifier_names

class ComptoireOrderModel {
  final String? cmd_code;
  final String? proforma_code;
  final String order_time;
  final String responsable;
  final String section;
  final String? fiche_number;
  final String? devis_number;
  final String? car_no_plate;
  final String? client_name;
 

  ComptoireOrderModel({this.client_name, required this.section, this.fiche_number, this.devis_number, this.car_no_plate, this.cmd_code, this.proforma_code, required this.order_time, required this.responsable});
  factory ComptoireOrderModel.fromJson(dynamic json) {
    return ComptoireOrderModel(
      client_name: json["client_name"],
      fiche_number: json['fiche_number'],devis_number: json['devis_number'], car_no_plate: json['car_no_plate'],
      cmd_code: json['cmd_code'], proforma_code: json['proforma_code'], order_time: json['order_time'], responsable: json['responsable'], section: json['section']);
  }
}

class OrderProduct {
    final String product_name;
    final String product_reference;
    // final String product_location;
    final String product_group;
    final double product_qty;
    final double product_price;

  OrderProduct({required this.product_name, required this.product_reference, required this.product_group, required this.product_qty, required this.product_price});

  factory OrderProduct.fromJson(dynamic json) {
      return OrderProduct(product_name: json['product_name'], product_reference: json['product_reference'], product_group: json['product_group'], product_qty: json['product_qty'], product_price: json['product_price']);
  }

  @override
  String toString() {

    return " $product_name \n Ref: $product_reference \n Group: $product_group ";
  }

}