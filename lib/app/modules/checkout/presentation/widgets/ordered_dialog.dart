import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../app_controller.dart';
import '../../../../core/data/datasources/local_storage.dart';
import '../../../../core/domain/utils/number_formatter.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../cart/data/datasources/cart_data_source.dart';
import '../../../product/data/models/product_model.dart';
import '../../data/models/order_model.dart';
import '../../domain/consts/string.dart';
import '../stores/pdf_store.dart';

class PDFEntity {
  String path;
  PDFEntity(
    this.path,
  );
}

///ignore: must_be_immutable
class OrderedDialog extends StatelessWidget {
  final OrderModel orderModel;
  OrderedDialog({
    this.orderModel,
  }) {
    _pdfStore.saveProducts(orderModel);
  }
  final _controller = Modular.get<AppController>();
  final _cartDataSource = Modular.get<CartDataSource>();
  final _pdfStore = Modular.get<PDFStore>();
  final pdf = pw.Document();
  String pdfPath;

  writeOnPdf() async {
    List<String> products;
    await LocalStorage.instance
        .getStringList(PRODUCTS)
        .then((value) => products = value);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32.0),

        /// writing pdf
        build: (pw.Context context) {
          _buildHeaderCustomerInfo(String title, String data) {
            return pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Container(
                    width: 100.0,
                    child: pw.Text('$title:',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                pw.SizedBox(width: 3.0),
                pw.Container(
                    padding: pw.EdgeInsets.only(right: 32.0),
                    width: 150,
                    child: pw.Text(data)),
              ],
            );
          }

          return <pw.Widget>[
            pw.Header(
              padding: pw.EdgeInsets.symmetric(vertical: 10.0),
              level: 0,
              child: pw.Column(
                children: [
                  pw.Center(
                    child: pw.Text(
                      'Nota de Encomenda'.toUpperCase(),
                      style: pw.TextStyle(fontSize: 16.0),
                    ),
                  ),
                  pw.SizedBox(height: 20.0),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text(
                        'Izy Shop',
                        style: pw.TextStyle(
                          fontStyle: pw.FontStyle.italic,
                          fontSize: 20.0,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Container(
                          width: 230,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              _buildHeaderCustomerInfo(
                                'Entrega',
                                orderModel.deliveryTime,
                              ),
                              _buildHeaderCustomerInfo(
                                'Exmo(a) Sr(a)',
                                orderModel.customerName,
                              ),
                              _buildHeaderCustomerInfo(
                                'Endereço',
                                orderModel.location,
                              ),
                              _buildHeaderCustomerInfo(
                                'Contacto',
                                orderModel.onDeliveryPhone,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            pw.Header(
                padding: pw.EdgeInsets.symmetric(vertical: 10.0),
                level: 1,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Container(
                      width: 120,
                      child: pw.Text('Item.',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.SizedBox(width: 20.0),
                    pw.Container(
                      width: 60,
                      child: pw.Text('Qtd.',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.SizedBox(width: 20.0),
                    pw.Container(
                      width: 70,
                      child: pw.Text('Preço Unit.',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.SizedBox(width: 20.0),
                    pw.Container(
                      width: 80,
                      child: pw.Text('Total.',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                  ],
                )),
            pw.Column(
                children: products.map((_item) {
              ProductModel item = ProductModel.fromMap(json.decode(_item));
              String _key;
              if (item.hasSize || item.hasVol || item.hasWeight) {
                item.selectedItem.keys.map((k) => _key = k).toList();
              }
              return pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(width: 120, child: pw.Text('- ${item.name}')),
                  pw.SizedBox(width: 20.0),
                  pw.Container(width: 60, child: pw.Text(item.qty.toString())),
                  pw.SizedBox(width: 20.0),
                  pw.Container(
                    width: 70,
                    child: pw.Text(item.hasSize || item.hasVol || item.hasWeight
                        ? '${NumberFormatter.instance.numToString(item.selectedItem[_key])} MT'
                        : '${item.price} MT'),
                  ),
                  pw.SizedBox(width: 20.0),
                  pw.Container(
                    width: 80,
                    child: pw.Text(item.hasSize || item.hasVol || item.hasWeight
                        ? '${NumberFormatter.instance.numToString(item.selectedItem[_key] * item.qty)} MT'
                        : '${item.price * item.qty} MT'),
                  ),
                ],
              );
            }).toList()),
            pw.Header(
              padding: pw.EdgeInsets.symmetric(vertical: 10.0),
              level: 1,
              child: pw.Center(
                  child: pw.Text('Processado pelo Aplicativo',
                      style: pw.TextStyle(fontStyle: pw.FontStyle.italic))),
            ),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Container(
                width: 200,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.RichText(
                      text: pw.TextSpan(children: [
                        pw.TextSpan(
                          text: 'Total Produtos: ',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.TextSpan(
                          text:
                              '${NumberFormatter.instance.numToString(orderModel.subtotal).toString()} MT',
                        ),
                      ]),
                    ),
                    pw.RichText(
                      text: pw.TextSpan(children: [
                        pw.TextSpan(
                          text: 'Preço Entrega: ',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.TextSpan(
                          text:
                              '${NumberFormatter.instance.numToString(orderModel.deliveryAmount).toString()} MT',
                        ),
                      ]),
                    ),
                    pw.RichText(
                      text: pw.TextSpan(children: [
                        pw.TextSpan(
                          text: 'Total: ',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.TextSpan(
                          text:
                              '${NumberFormatter.instance.numToString(orderModel.amount).toString()} MT',
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
            pw.SizedBox(height: 20.0),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.RichText(
                  text: pw.TextSpan(children: [
                    pw.TextSpan(text: 'Dados Bancários: '),
                    pw.TextSpan(
                      text: 'IZY SHOP, S.A',
                      style: pw.TextStyle(color: PdfColors.green),
                    ),
                  ]),
                ),
                pw.RichText(
                  text: pw.TextSpan(children: [
                    pw.TextSpan(text: 'Banco: '),
                    pw.TextSpan(
                      text: 'BCI',
                      style: pw.TextStyle(color: PdfColors.green),
                    ),
                  ]),
                ),
                pw.RichText(
                  text: pw.TextSpan(children: [
                    pw.TextSpan(text: 'Conta Número: '),
                    pw.TextSpan(
                      text: '11278830310001',
                      style: pw.TextStyle(color: PdfColors.green),
                    ),
                    pw.TextSpan(text: ' / NIB: '),
                    pw.TextSpan(
                      text: '0008.0000.12788303101.95',
                      style: pw.TextStyle(color: PdfColors.green),
                    ),
                  ]),
                ),
                pw.RichText(
                  text: pw.TextSpan(children: [
                    pw.TextSpan(text: 'Moeda: '),
                    pw.TextSpan(
                      text: 'MZM',
                      style: pw.TextStyle(color: PdfColors.green),
                    ),
                  ]),
                ),
                pw.RichText(
                  text: pw.TextSpan(children: [
                    pw.TextSpan(text: 'Forma de Pagamento: '),
                    pw.TextSpan(
                      text: 'Trans',
                      style: pw.TextStyle(color: PdfColors.green),
                    ),
                  ]),
                ),
                pw.Header(
                  padding: pw.EdgeInsets.symmetric(vertical: 7.0),
                  level: 1,
                  child: pw.Center(
                    child: pw.Text(
                      'Compras no valor inferior a 3,999.00MT estão sujeitas a taxa de entrega.',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            pw.Center(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text('IZYSHOP, Sociedade Anónima'),
                  pw.Text('Rua da Amizade, Casa número 41 RC, Maputo'),
                  pw.Text('Maputo, Moçambique'),
                  pw.Text('info@izyshop.co.mz'),
                  pw.Text('+258 82 330 35 32'),
                  pw.Text('+258 84 330 35 32'),
                ],
              ),
            ),
          ];
        },
      ),
    );
  }

  _buildContentRow(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
      height: 200.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ORDER COMPLETE \nThank You!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black87, fontSize: 22.0),
          ),
          Expanded(child: SizedBox()),
          RoundedButton(
            isGreenColor: true,
            btnWidth: 70.0,
            btnHeight: 70.0,
            iconSize: 30.0,
            icon: Icons.check,
            text: 'OK!',
            textColor: Colors.black54,
            onTap: () async {
              await _pdfStore.pdfPath.then((path) => pdfPath = path);
              _controller.select(9);
              _cartDataSource.removeAll();

              /// sendind report to email
              await writeOnPdf();
              _pdfStore.savePdf(pdf, path: pdfPath);
              File file = File(pdfPath);
              orderModel.sendOrderReport(file);
              Modular.to.pop();
              // Modular.to.pushNamed('/pdf-viewer', arguments: PdfRoute(pdfPath));
            },
            index: 9,
          ),
        ],
      ),
    );
  }

  _buildBody(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.white.withOpacity(0.75),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      children: [
        Stack(
          overflow: Overflow.visible,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _buildContentRow(context),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
