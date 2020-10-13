import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

import 'package:izy_shop/app/core/domain/entities/route_entity.dart';

import '../../../../core/domain/consts/api.dart';

class MapsPage extends StatefulWidget {
  final RouteEntity _routeEntity;
  static final kInitialPosition = LatLng(-25.967, 32.583);
  MapsPage(
    this._routeEntity,
  );

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  _buildSelectedPlace(PickResult selectedPlace) {
    return Material(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white.withOpacity(0.6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedPlace.formattedAddress != null
                    ? '${selectedPlace.formattedAddress}'
                    : '',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Material(
              color: Colors.green[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              elevation: 5.0,
              child: Container(
                height: 50,
                width: 50,
                child: IconButton(
                  padding: EdgeInsets.all(10.0),
                  color: Colors.white,
                  icon: Icon(FontAwesomeIcons.check, size: 30.0),
                  onPressed: () {
                    widget._routeEntity.addressController.text =
                        selectedPlace.formattedAddress;
                    widget._routeEntity.orderModel.latitude =
                        selectedPlace.geometry.location.lat;
                    widget._routeEntity.orderModel.longitude =
                        selectedPlace.geometry.location.lng;
                    Modular.to.pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildResultTile({PickResult selectedPlace, SearchingState state}) {
    if (state != SearchingState.Searching)
      return _buildSelectedPlace(selectedPlace);
  }

  _buildBody() {
    return PlacePicker(
      apiKey: PLACES_KEY,
      initialPosition: MapsPage.kInitialPosition,
      useCurrentLocation: true,
      hintText: "Search location...",
      searchingText: "Loading...",
      autoCompleteDebounceInMilliseconds: 500,
      region: 'mz',
      selectInitialPosition: true,
      selectedPlaceWidgetBuilder:
          (_, selectedPlace, state, bool isSearchBarFocused) {
        return isSearchBarFocused
            ? Container()
            : Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: _buildResultTile(
                      selectedPlace: selectedPlace, state: state),
                ),
              );
      },
      pinBuilder: (context, state) {
        if (state == PinState.Idle) {
          return Icon(
            Icons.location_on,
            size: 50.0,
            color: Colors.red,
          );
        } else {
          return Icon(
            Icons.location_on,
            size: 40.0,
            color: Colors.green[300],
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }
}
