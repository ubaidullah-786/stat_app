import 'package:cached_network_image/cached_network_image.dart';
import 'package:stats_app/helper/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ScheduleDialog extends StatefulWidget {
  const ScheduleDialog(
      {super.key,
      required this.eventName,
      required this.eventTime,
      required this.eventLoc,
      required this.wikipedia});

  final String eventName;
  final DateTime eventTime;
  final String eventLoc;
  final String wikipedia;

  @override
  State<StatefulWidget> createState() => _ScheduleDialogState();
}

class _ScheduleDialogState extends State<ScheduleDialog> {
  @override
  initState() {
    super.initState();
    getData(
        widget.wikipedia.split("/")[widget.wikipedia.split("/").length - 1]);
  }

  late String imageLink = " ";

  late String about = "Loading...";

  bool isTriedGetData = false;

  Future<void> getData(String wikipediaTitle) async {
    try {
      var url = Uri.https('en.wikipedia.org',
          '/api/rest_v1/page/summary/${Uri.decodeComponent(wikipediaTitle)}');

      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;

        setState(() {
          imageLink = jsonResponse["thumbnail"]["source"];
        });
      } else {
        if (!isTriedGetData) {
          getData(widget.wikipedia);
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
    return _dialog(
        widget.eventName, widget.eventTime, widget.eventLoc, imageLink);
  }

  _dialog(eventName, DateTime eventTime, eventLoc, eventUrl) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              eventName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              DateFormatter.getFormattedDate(eventTime),
              style: const TextStyle(fontSize: 15),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(eventLoc, style: const TextStyle(fontSize: 15)),
            Text(DateFormatter.getFormattedTime(eventTime),
                style: const TextStyle(fontSize: 15)),
          ],
        ),
        const SizedBox(height: 10),
        CachedNetworkImage(
          imageUrl: eventUrl,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
