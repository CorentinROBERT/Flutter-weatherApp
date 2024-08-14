import 'package:flutter/material.dart';
import 'package:weather_app/model/geoposition.dart';

class MyDrawer extends StatelessWidget {
  GeoPosition? myPosition;
  List<String> cities;
  Function(String) onTap;
  Function(String) onRemove;

  MyDrawer(
      {required this.myPosition,
      required this.cities,
      required this.onTap,
      required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final itemCount =
        myPosition == null ? cities.length + 1 : cities.length + 2;
    return Drawer(
      child: ListView.separated(
          itemBuilder: (contex, index) {
            if (index == 0) return header(context);
            if (index == 1 && myPosition != null) {
              return tappableList(myPosition!.city, false);
            }
            if (myPosition == null) {
              return tappableList(cities[index - 1], true);
            }
            return tappableList(cities[index - 2], true);
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: itemCount),
    );
  }

  DrawerHeader header(BuildContext context) {
    return DrawerHeader(
        child: Column(
      children: [
        Icon(Icons.location_on_outlined,
            size: 32, color: Theme.of(context).primaryColor),
        const Text("Mes villes")
      ],
    ));
  }

  ListTile tappableList(String string, bool canDelete) {
    return ListTile(
      title: Text(string),
      onTap: () {
        onTap(string);
      },
      trailing: canDelete
          ? IconButton(
              onPressed: () => onRemove(string), icon: const Icon(Icons.delete))
          : null,
    );
  }
}
