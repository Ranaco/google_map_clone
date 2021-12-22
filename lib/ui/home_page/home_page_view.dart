import 'package:flutter/material.dart';
import 'package:google_map_clone/respository/direction_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:google_map_clone/ui/home_page/home_page_viewmodel.dart';

import 'custom_drawer/custom_drawer_viewmodel.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    super.initState();
  }

  onToggle() {
    animationController!.isDismissed
        ? animationController!.forward()
        : animationController!.reverse();
  }

  onToggle1() {
    animationController!.forward();
  }

  var maxSlide = 125.0;
  var scale = 0.7;
  var y = 0.0;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
        viewModelBuilder: () => HomePageViewModel(),
        onModelReady: (model) => model.initMap(),
        builder: (context, model, child) {
          void _addMarker(LatLng pos) async {
            if (model.initMarker == null ||
                (model.initMarker != null && model.secondMarker != null)) {
              setState(() {
                model.initMarker = Marker(
                    markerId: const MarkerId("origin"),
                    position: pos,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueCyan),
                    infoWindow: const InfoWindow(title: "Origin"));
                model.secondMarker = null;
                model.directions = null;
              });
            } else {
              setState(() {
                model.secondMarker = Marker(
                    markerId:const MarkerId("Destination"),
                    position: pos,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueViolet));
              });
              final directions = await DirectionRepository().getDirection(origin: model.initMarker!.position, destination: pos);
            }
          }

          return model.isBusy
              ? const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Stack(
                  children: [
                    const CustomDrawer(),
                    GestureDetector(
                      onTap: () {
                        onToggle1();
                      },
                      child: AnimatedBuilder(
                          animation: animationController!,
                          builder: (context, child) {
                            double slide =
                                maxSlide * animationController!.value * 1.5;
                            // double ye = -y *  animationController!.value * 4;
                            double scale =
                                1 - (animationController!.value * 0.3);
                            return Transform(
                              transform: Matrix4.identity()
                                ..translate(slide, slide / 1.5)
                                ..scale(scale),
                              child: Scaffold(
                                backgroundColor: Colors.transparent,
                                body: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      animationController!.isDismissed
                                          ? 0
                                          : 20),
                                  child: Stack(
                                    children: [
                                      GoogleMap(
                                        onMapCreated: (controller) => model
                                            .googleMapController = controller,
                                        initialCameraPosition:
                                            model.initLocation,
                                        mapType: model.mapType,
                                        markers: {
                                          if (model.initMarker != null)
                                            model.initMarker!,
                                          if (model.secondMarker != null)
                                            model.secondMarker!
                                        },
                                        zoomControlsEnabled: true,
                                        myLocationButtonEnabled: false,
                                        onLongPress: _addMarker,
                                        polylines: {
                                          if(model.directions != null)
                                            Polyline(
                                              polylineId: PolylineId("Get Directions"),
                                              width: 5,
                                              color: Colors.red,
                                              points: model.directions!.polylinePoints!.map((e) => LatLng(e.latitude, e.longitude)).toList(),
                                            ),
                                        },
                                      ),
                                      Positioned(
                                        left: 30,
                                        top: 50,
                                        child: Container(
                                          height: 45,
                                          width: 350,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Form(
                                            key: model.formKey,
                                            child: TextFormField(
                                                onChanged: (value) {
                                                  model.place = value;
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "";
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                    suffixIcon: GestureDetector(
                                                      onTap: () {
                                                        model.verifyPlace(
                                                            model.formKey);
                                                      },
                                                      child: const Icon(
                                                        Icons.search,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    prefixIcon: GestureDetector(
                                                      onTap: () {
                                                        onToggle();
                                                      },
                                                      child: const Icon(
                                                          Icons.menu),
                                                    ),
                                                    hintText: "Search",
                                                    border: InputBorder.none)),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          top: 120,
                                          left: 320,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Center(
                                                child: ChooseMapType()),
                                          ))
                                    ],
                                  ),
                                ),
                                floatingActionButton: FloatingActionButton(
                                  backgroundColor: Colors.white,
                                  onPressed: () {
                                    model.directions != null ?
                                        model.googleMapController!.animateCamera(CameraUpdate.newLatLngBounds(model.directions!.bounds!,100.0 )):
                                    model.googleMapController!.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                            model.initLocation));
                                  },
                                  child: const Icon(
                                    Icons.center_focus_strong,
                                    color: Colors.black,
                                  ),
                                ),
                                floatingActionButtonLocation:
                                    FloatingActionButtonLocation.centerFloat,
                              ),
                            );
                          }),
                    ),
                  ],
                );
        });
  }
}

class ChooseMapType extends ViewModelWidget<HomePageViewModel> {
  const ChooseMapType({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, HomePageViewModel viewModel) {
    return PopupMenuButton(
        onSelected: (int value) {
          viewModel.changeMapType(value);
        },
        icon: const Icon(
          Icons.layers_outlined,
          color: Colors.black,
          size: 35,
        ),
        itemBuilder: (context) {
          return [
            const PopupMenuItem(
                value: 0,
                child: ListTile(
                  title: Text("Satellite"),
                  leading: Icon(Icons.satellite),
                )),
            const PopupMenuItem(
                value: 1,
                child: ListTile(
                  title: Text("Normal"),
                  leading: Icon(Icons.circle),
                )),
            const PopupMenuItem(
                value: 2,
                child: ListTile(
                  title: Text("Terrain"),
                  leading: Icon(Icons.terrain),
                )),
            const PopupMenuItem(
                value: 3,
                child: ListTile(
                  title: Text("hybrid"),
                  leading: Icon(Icons.catching_pokemon),
                )),
          ];
        });
  }
}
