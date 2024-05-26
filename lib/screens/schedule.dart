import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:stats_app/models/race.dart';
import 'package:stats_app/models/race_data_source.dart';
import 'package:stats_app/screens/schedule_dialogue.dart';
import 'package:stats_app/providers/schedule_provider.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ScheduleProvider>(
        builder: (context, scheduleProvider, child) {
          if (scheduleProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (scheduleProvider.hasError) {
            return _error();
          } else if (scheduleProvider.races.isEmpty) {
            return _error();
          } else {
            return _races(context, scheduleProvider.races);
          }
        },
      ),
    );
  }

  Widget _races(BuildContext context, List<Race> races) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SfCalendar(
          view: CalendarView.schedule,
          appointmentBuilder: (BuildContext context,
              CalendarAppointmentDetails calendarAppointmentDetails) {
            return Container(
              decoration: BoxDecoration(
                color: calendarAppointmentDetails.appointments.first
                    .getBackground(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  calendarAppointmentDetails.appointments.first.getEventName() +
                      "\n" +
                      calendarAppointmentDetails.appointments.first
                          .getFrom()
                          .toString()
                          .split(" ")[1]
                          .split(".")[0]
                          .substring(0, 5),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            );
          },
          scheduleViewSettings: const ScheduleViewSettings(
            appointmentItemHeight: 60,
            monthHeaderSettings: MonthHeaderSettings(
              height: 70,
              textAlign: TextAlign.start,
              monthTextStyle: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          dataSource: RaceDataSource(races),
          onTap: (CalendarTapDetails details) {
            String eventName = details.appointments?[0].getEventName() ?? "";
            String eventLoc = details.appointments?[0].getEventLoc() ?? "";

            DateTime eventDate = details.appointments?[0].getFrom() ?? "";
            String year = eventDate.year.toString();

            String eventUrl = details.appointments?[0]
                    .getEventUrl()
                    .replaceAll(year + "_", "") ??
                "";
            if (details.appointments?[0].getEventName() != null) {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        width: 5,
                      ),
                    ),
                    insetPadding: const EdgeInsets.all(0),
                    content: ScheduleDialog(
                      eventName: eventName,
                      eventTime: eventDate,
                      eventLoc: eventLoc,
                      wikipedia: eventUrl,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _error() {
    return Container(
      child: Center(child: Image.asset("assets/images/error.png")),
    );
  }
}
