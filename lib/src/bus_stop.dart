part of bus_stop;

typedef WidgetBuilder = Widget Function(BuildContext context);
typedef BusStopBuilder = Widget Function(BuildContext context, bool didFire);

/// Listens to [EventBus] for event [E] and does things with it.
class BusStop<E extends BusEvent> extends StatefulWidget {
  /// [EventBus] that is listened to.
  final EventBus eventBus;

  /// Builder that handles what to display based on whether event has fired.
  final BusStopBuilder builder;

  /// Optional error widget.
  final WidgetBuilder error;

  /// If set to true, [snackBarContext] and [snackBar] must not be null.
  final bool doShowSnackBar;

  /// [BuildContext] containing [Scaffold] to show [snackBar] in.
  final BuildContext snackBarContext;

  /// [SnackBar] to display when event fires.
  final SnackBar snackBar;

  BusStop({
    @required this.eventBus,
    @required this.builder,
    this.error,
    this.doShowSnackBar = false,
    this.snackBarContext,
    this.snackBar,
  })  : assert(eventBus != null, 'eventBus cannot be null'),
        assert(builder != null, 'builder cannot be null'),
        assert(
            !doShowSnackBar || (snackBarContext != null && snackBar != null));

  @override
  State<StatefulWidget> createState() => _BusStopState<E>();
}

class _BusStopState<E> extends State<BusStop> {
  @override
  void initState() {
    /// Shows SnackBar
    widget.eventBus.on<E>().listen((onData) {
      if (widget.doShowSnackBar) {
        Scaffold.of(widget.snackBarContext).showSnackBar(widget.snackBar);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.eventBus.on<E>(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          if (widget.error != null)
            return widget.error(context);
          else
            return SizedBox();
        }

        bool didEventFire = snapshot.hasData;
        return widget.builder(context, didEventFire);
      },
    );
  }
}
