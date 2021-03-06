import 'dart:io';

import 'package:Haritkranti/Screens/Buttons/getin.dart';
import 'package:Haritkranti/get_location.dart';
import 'package:Haritkranti/variables.dart';
import 'package:Haritkranti/village_map_model.dart';
// import 'package:fertilizercalculator/src/resources/Agent/UploadImage/upload_village_map.dart';
import 'package:Haritkranti/custom_colors.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VillageMapping extends StatefulWidget {


  final String userId;
  final String userToken;
  final String landId;
  final String villageId;

  const VillageMapping({
    Key key,
    this.userId,
    this.userToken,
    this.landId,
    this.villageId,
  }) : super(key: key);



  @override
  _VillageMappingState createState() => _VillageMappingState();

}

class _VillageMappingState extends State<VillageMapping> {



  AudioCache audioCache = AudioCache();

  

   
  


  GetLocationForFarm getLocation = GetLocationForFarm();
  double latitude;
  double longitude;

  Set<Marker> markers = Set();
  GoogleMapController mapController;
  List<LatLng> latList = [];
  List<LocationPin> finalLatLongList = [];
  Set<Polygon> polList = Set();
  Marker mark;
  LatLng startPoint;

  double nValue = 0;
  double pValue = 0;
  double kValue = 0;

  String soilT = "Yes";

  File _image;
  var delete = false;
  var fileName;
  var _imageData;
  String imageUrl;
  String _id;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future getVillageMap() async {
    final response = await http.get(
      Uri(
        host: host,
        port: port,
        scheme: scheme,
        path: '/haritkranti-0.0.1-SNAPSHOT/api/getGeoLocationMappingByType',

        queryParameters: {
          "userId": '5def3bde5bf1ed369224a5a4',
        },
      ),
    );

    if (response.statusCode == 200) {
      if (response.body != "") {
        print("polygondtata"+response.body);
        var data = json.decode(response.body);
        return data;
      } else {
        return response.statusCode;
      }
    } else {
      print("nopolyg"+response.body);
      return response.statusCode;
    }
  }

  @override
  void initState() {
     audioCache.play('d.wav');
    // addMarker();
    getLocation.getLocation().then((value) {
      print(value.toString());
      setState(() {
        latitude = value['latitude'];
        longitude = value['longitude'];
      });
      print(value['latitude']);
      print(value['longitude']);
      getVillageMap().then((val) {
        if (val != null) {
          print(val);
          if (val.runtimeType != int) {
            _id = val['id'];
            imageUrl = val['villageMapImageUrl'];
            for (int i = 0; i < val['locationPins'].length; i++) {
              latList.add(LatLng(
                  double.parse(val['locationPins'][i]['lattitude']),
                  double.parse(val['locationPins'][i]['longitude'])));
              finalLatLongList.add(LocationPin(
                lattitude: val['locationPins'][i]['lattitude'],
                longitude: val['locationPins'][i]['longitude'],
              ));
            }
            polList.add(
              Polygon(
                polygonId: PolygonId("1"),
                points: latList,
                fillColor: Colors.green.withOpacity(0.2),
              ),
            );
            print(latList);
            print(polList);
            if (latList.length > 0) {
              setState(() {
                startPoint = latList[0];
              });
            } else {
              setState(() {
                startPoint = LatLng(latitude, longitude);
              });
            }
          } else {
            setState(() {
              startPoint = LatLng(latitude, longitude);
            });
          }
        } else {
          setState(() {
            startPoint = LatLng(latitude, longitude);
          });
        }
      });
    });

    super.initState();
  }

  void _select(String value) {
    print(value);
    //getImageGallery(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          'Khasra Map',
          style: TextStyle(color: titleColor),
        ),
        actions: _id != null
            ? <Widget>[

              ]
            : <Widget>[],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/backgroundimg.jpg',
            fit: BoxFit.cover,
          ),


          latitude != null && longitude != null && startPoint != null
              ? Flexible(child: Column(
            children: <Widget>[
    Flexible(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.only(top: 5,),
          child:
          Align(
            //alignment: Alignment.topCenter,
            child: CircleAvatar(
              //backgroundColor: kWhiteColor,
              backgroundImage: AssetImage('assets/images/icon.png'),
              radius: 50,
            ),
          ),)),

              Flexible(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(top: 8),
                   padding: const EdgeInsets.only(left: 5),
                   // margin: EdgeInsets.fromLTRB(2,2,2,2),
                    color: Colors.lightGreen,
                  height: 100.0,
                  width: MediaQuery.of(context).size.width * 0.97,
                    child: Text("हरित क्रांति आत्म निर्भर कृषक के रूप में आपका स्वागत है",style: TextStyle(fontSize: 25,color: Colors.white),),
                  )),


    Flexible(
        flex: 3,
        child:
    Container(
      margin: const EdgeInsets.only(top: 8,bottom: 10),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  onTap: (val) {
                    print(val.latitude);
                    print(val.longitude);
                    latList.add(LatLng(val.latitude, val.longitude));
                    finalLatLongList.add(
                      LocationPin(
                        lattitude: val.latitude.toString(),
                        longitude: val.longitude.toString(),
                      ),
                    );
                  },
                  polygons: polList,
                  markers: markers,
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  mapType: MapType.satellite,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: startPoint,
                    zoom: 20.0,
                  ),
                ),
               
              )
              
            
              ),

              Flexible(
        flex: 1,
        child: Container(
          child: Column(
            
        children: [

          BeGetin(),
        ],
            
          ),
         
            
          )),
              
            ],
          ))
              : Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
