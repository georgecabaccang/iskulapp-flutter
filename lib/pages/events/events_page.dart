import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/helper_widgets/infinite_scroll_list_view_builder.dart';
import 'package:school_erp/pages/events/helpers/mock_events.dart';
import 'package:school_erp/pages/events/wdigets/event_content.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';

class EventsPage extends StatefulWidget {
    const EventsPage({super.key});

    @override
    createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
    late final List<Event> _events = [];

    // Adjust number of rows to retreive on request
    final int _countPerLoad = 10;

    bool _isLoading = false;
    int _currentOffset = 0;

    @override
    void initState() {
        super.initState();
        _loadEvents();
    }

    Future<void> _loadEvents() async {
        try {
            if (!mounted) return;

            setState(() {
                    _isLoading = true;
                }
            );

            List<Event> fetchedEvents =
                await DummyEventDatabase().getFeeds(_currentOffset, _countPerLoad);

            if (fetchedEvents.isNotEmpty) {
                setState(() {
                        _isLoading = false;
                        _events.addAll(fetchedEvents);

                        _currentOffset += fetchedEvents.length;
                    }
                );
            }

            setState(() {
                    _isLoading = false;
                }
            );
        } 
        // Handler errors better when real data is being retrieved
        catch (error) {
            if (!mounted) return;
            setState(() {
                    _isLoading = false;
                }
            );
        }
    }

    @override
    Widget build(BuildContext context) {
        return DefaultLayout(
            title: "Events Page", 
            content: [
                InfiniteScrollListView(
                    listOfData: _events, 
                    currentOffset: _currentOffset, 
                    isLoading: _isLoading, 
                    loadMoreData: _loadEvents,
                    itemBuilder: (context, event) => EventContent(eventContent: event), 

                )
            ]
        );
    }
}