import 'package:flutter/material.dart';
import 'package:school_erp/pages/events/helpers/mock_events.dart';
import 'package:school_erp/pages/events/wdigets/event_content.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final ScrollController _scrollController = ScrollController();
  late final List<Event> _events = [];

  // Adjust number of rows to retreive on request
  final int _countPerLoad = 10;

  bool _isLoading = false;
  int _currentOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadEvents();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!_isLoading) {
        _loadEvents();
      }
    }
  }

  Future<void> _loadEvents() async {
    setState(() {
      _isLoading = true;
    });

    List<Event> fetchedEvents =
        await DummyEventDatabase().getFeeds(_currentOffset, _countPerLoad);

    setState(() {
      _isLoading = false;
      _events.addAll(fetchedEvents);

      if (fetchedEvents.length < _countPerLoad) {
        _currentOffset += fetchedEvents.length;
      } else {
        _currentOffset += _countPerLoad;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(title: "Events Page", content: [
      Expanded(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _currentOffset + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == _events.length) {
              return _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox.shrink();
            }
            return EventContent(eventContent: _events[index]);
          },
        ),
      ),
    ]);
  }
}
