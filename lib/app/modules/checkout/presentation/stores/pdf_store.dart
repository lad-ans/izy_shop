import 'dart:convert';
import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../core/data/datasources/local_storage.dart';
import '../../data/models/order_model.dart';
import '../../domain/consts/string.dart';

part 'pdf_store.g.dart';

@Injectable()
class PDFStore = _PDFStoreBase with _$PDFStore;

abstract class _PDFStoreBase with Store {
  saveProducts(OrderModel orderModel) async {
    await LocalStorage.instance.removeData(PRODUCTS);
    List<String> data =
        orderModel.products.map((item) => json.encode(item.toMap())).toList();
    await LocalStorage.instance.setStringList(PRODUCTS, data);
  }

  void savePdf(pw.Document pdf, {String path}) {
    File file = File(path);
    file.writeAsBytesSync(pdf.save());
  }

  Future<String> get pdfPath async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    return '$documentPath/izyshop_report_${DateTime.now().hour}_${DateTime.now().minute}_${DateTime.now().day}_${DateTime.now().month}_${DateTime.now().year}.pdf';
  }
}
