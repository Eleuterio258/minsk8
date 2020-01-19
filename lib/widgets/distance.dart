import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:minsk8/import.dart';

class Distance extends StatefulWidget {
  final LatLng location;

  Distance(this.location);

  @override
  _DistanceState createState() {
    return _DistanceState();
  }
}

class _DistanceState extends State<Distance> {
  final icon = Icons.location_on;
  final iconSize = 16.0;

  double value;

  @override
  void initState() {
    super.initState();
    _updateValue();
    _updateCurrentPosition();
    // WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  // void _afterLayout(_) {
  //   _updateValue();
  //   _updateCurrentPosition();
  // }

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return Container();
    }
    Widget text = RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          WidgetSpan(
            child: SizedBox(
              height: iconSize,
              child: RichText(
                text: TextSpan(
                  text: String.fromCharCode(icon.codePoint),
                  style: TextStyle(
                    fontSize: iconSize,
                    fontFamily: icon.fontFamily,
                    color: Colors.pinkAccent,
                  ),
                ),
              ),
            ),
          ),
          TextSpan(
            style: DefaultTextStyle.of(context).style.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.8),
                ),
            text: '${value.toStringAsFixed(2)} км',
          ),
        ],
      ),
    );
    return Tooltip(
      message: 'Distance',
      child: Material(
        child: InkWell(
          child: Container(
            height: kButtonHeight,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: text,
          ),
          onTap: _onTap,
        ),
      ),
    );
  }

  _onTap() {}

  void _updateValue() async {
    double distanceInMeters = await Geolocator().distanceBetween(
        appState['currentPosition'][0],
        appState['currentPosition'][1],
        widget.location.latitude,
        widget.location.longitude);
    setState(() {
      value = distanceInMeters / 1000;
    });
  }

  void _updateCurrentPosition() async {
    final geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();
    if (GeolocationStatus.granted == geolocationStatus) {
      try {
        final position = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
        final oldCurrentPosition = appState['currentPosition'];
        appState['currentPosition'] = [position.latitude, position.longitude];
        if (oldCurrentPosition != null &&
            oldCurrentPosition[0] == appState['currentPosition'][0] &&
            oldCurrentPosition[1] == appState['currentPosition'][1]) {
          return;
        }
        _updateValue();
      } catch (error) {
        debugPrint(error.toString());
      }
    }
  }
}