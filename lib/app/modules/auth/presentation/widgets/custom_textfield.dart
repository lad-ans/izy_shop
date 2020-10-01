import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';

import '../../../home/data/datasources/moz_city.dart';

class CustomTextField extends StatefulWidget {
  final bool filled;
  final String labelText;
  final Color fillColor;
  final double height;
  final TextEditingController controller;
  const CustomTextField({
    Key key,
    this.filled = false,
    this.labelText = '',
    this.fillColor,
    this.height,
    this.controller,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  GlobalKey<AutoCompleteTextFieldState<MozCity>> _key = GlobalKey();
  AutoCompleteTextField autoCompleteTextField;
  TextEditingController _editingController = TextEditingController();

  Widget buildCityRow(MozCity cityModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.location_on, color: Colors.red[100], size: 15),
          SizedBox(width: 3),
          Expanded(
              child:
                  Text(cityModel.city, style: TextStyle(color: Colors.grey))),
          Text(cityModel.country, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? null,
      child: autoCompleteTextField = AutoCompleteTextField<MozCity>(
        key: _key,
        suggestions: MozCity.cities,
        itemFilter: (item, query) {
          return item.city.toLowerCase().startsWith(query.toLowerCase());
        },
        itemSorter: (a, b) {
          return a.city.compareTo(b.city);
        },
        itemSubmitted: (item) {
          setState(() {
            autoCompleteTextField.textField.controller.text =
                "${item.city}, ${item.country}";
            _editingController.text = '${item.city}, ${item.country}';
          });
        },
        clearOnSubmit: false,
        controller: _editingController,
        itemBuilder: (context, item) {
          return buildCityRow(item);
        },
        style: TextStyle(color: Colors.black87),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12.0)),
            filled: widget.filled,
            fillColor: widget.filled ? widget.fillColor : null,
            labelText: widget.labelText,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelStyle: TextStyle(color: Colors.black26, fontSize: 15.0)),
      ),
    );
  }
}
