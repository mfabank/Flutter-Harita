import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> haritaKontrol = Completer();
  var baslangicKonumu =
      CameraPosition(target: LatLng(34.741282, 36.1844276), zoom: 4);
  Future<void> konumaGit() async {
    GoogleMapController controller = await haritaKontrol.future;
    var isaretKoy = Marker(
      markerId: MarkerId("Id"),
      position: LatLng(40.741282, 28.1844276),
      infoWindow: InfoWindow(title: "Geldiniz",snippet: "İşaretlenen Alan"),
    );

    setState(() {
      isaretlenenler.add(isaretKoy);
    });
    var gidilecekKonum =
        CameraPosition(target: LatLng(40.741282, 28.1844276), zoom: 8);
    controller.animateCamera(CameraUpdate.newCameraPosition(gidilecekKonum));
  }

  List <Marker> isaretlenenler = <Marker>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Haritalar İle Çalışma"),
        centerTitle: true,

      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: baslangicKonumu,
                markers: Set<Marker>.of(isaretlenenler),
                onMapCreated: (GoogleMapController controller) {
                  haritaKontrol.complete(controller);

                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("Konuma Git"),
                  onPressed: () {
                    konumaGit();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
