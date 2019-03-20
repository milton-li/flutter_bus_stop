# Bus Stop 🚍🚏

A simple Flutter widget that listens to Event Buses.

Learn more about [event buses](https://github.com/marcojakob/dart-event-bus).



## Getting Started 🚀

### Install

```yaml
dependencies:
  bus_stop: "^0.0.1"
```

### Import

```dart
import 'package:bus_stop/bus_stop.dart';
```



## Usage 🕹

Bus Stop can show a SnackBar and/or change the child Widget based whether the event fires. If `doShowSnackBar` is set to true, `snackBarContext` and `snackBar` must not be null where `snackBarContext` is a BuildContext that contains a Scaffold. 

```dart
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
```

