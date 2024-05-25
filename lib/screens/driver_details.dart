import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class DriverDetails extends StatefulWidget {
  const DriverDetails({
    super.key,
    required this.position,
    required this.driverName,
    required this.constructorName,
    required this.points,
    required this.wikipedia,
  });

  final String position;
  final String driverName;
  final String constructorName;
  final String points;
  final String wikipedia;

  @override
  State<DriverDetails> createState() => _FixtureItemState();
}

class _FixtureItemState extends State<DriverDetails> {
  @override
  void initState() {
    super.initState();
    getData(widget.wikipedia.split("/")[widget.wikipedia.split("/").length - 1]);
  }

  late String imageLink = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
  late String about = "Loading...";

  bool isTriedGetData = false;

  Future<void> getData(String wikipediaTitle) async {
    try {
      var url = Uri.https('en.wikipedia.org', '/api/rest_v1/page/summary/' + Uri.decodeComponent(wikipediaTitle));

      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

        setState(() {
          imageLink = jsonResponse["thumbnail"]["source"];
          about = jsonResponse["description"];
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
        if (!isTriedGetData) {
          getData(widget.driverName);
          isTriedGetData = true;
        } else {
          setState(() {
            about = "No data found";
          });
        }
      }
    } catch (e) {
      setState(() {
        about = "No data found";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        children: [
          Center(
            child: Stack(
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: imageLink,
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          buildName(widget.driverName, widget.constructorName),
          const SizedBox(height: 24),
          NumbersWidget(position: widget.position, points: widget.points),
          const SizedBox(height: 48),
          buildAbout(about),
        ],
      ),
    );
  }

  Widget buildName(String name, String constructor) => Column(
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(constructor),
        ],
      );

  Widget buildAbout(String about) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              about,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    leading: const BackButton(color: Colors.black),
    elevation: 0,
  );
}

class NumbersWidget extends StatelessWidget {
  const NumbersWidget({
    super.key,
    required this.position,
    required this.points,
  });

  final String position;
  final String points;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, "#" + position, 'Position'),
          buildDivider(),
          buildButton(context, points, 'Points'),
        ],
      );

  Widget buildDivider() => const SizedBox(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text) => MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
