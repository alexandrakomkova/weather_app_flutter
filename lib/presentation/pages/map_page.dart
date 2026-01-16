import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/presentation/cubit/address_tracker/address_tracker_cubit.dart';
import 'package:weather_app/presentation/cubit/location/location_cubit.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AddressTrackerCubit, AddressTrackerState>(
          builder: (_, state) {
            return Text(state.address);
          },
        ),
      ),
      body: const _MapView(),
    );
  }
}

class _MapView extends StatelessWidget {
  const _MapView();

  @override
  Widget build(BuildContext context) {
    return const _MapScreen();
  }
}

class _MapScreen extends StatefulWidget {
  const _MapScreen();

  @override
  State<_MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<_MapScreen> {
  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (_, state) {
        return GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: state.position == null
                ? LatLng(37.7749, -122.4194)
                : LatLng(state.position!.latitude, state.position!.longitude),
            zoom: 12,
          ),
          markers: state.mapMarkers ?? {},
        );
      },
    );
  }
}
