import 'package:flutter/material.dart';
import 'package:bus_stop/bus_stop.dart';
import 'package:event_bus/event_bus.dart';

void main() => runApp(MyApp());

EventBus bus = EventBus();

/// Event type.
class Event {}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Bus Stop Demo"),
        ),
        body: DemoWidget(),
      ),
    );
  }
}

class DemoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text("Fire Event"),
            onPressed: () {
              bus.fire(Event());
            },
          ),
          BusStop<Event>(
            eventBus: bus,
            builder: (BuildContext context, bool didEventFire) {
              // Uncomment below code to only use SnackBar
              // return SizedBox();

              if (didEventFire)
                return Text("Fired");
              else
                return Text("Not Fired");
            },
            doShowSnackBar: true,
            snackBarContext: context,
            snackBar: SnackBar(content: Text("Event Fired")),
          ),
        ],
      ),
    );
  }
}