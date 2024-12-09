import 'package:flutter/material.dart';
import 'package:school_erp/features/auth/auth_repository/schemas/user.dart';
import 'package:school_erp/pages/common_widgets/helper_widgets/infinite_scroll_list_view_builder.dart';
import 'package:school_erp/pages/home/app_body/views/feeds/widgets/feed_content.dart';
import 'package:school_erp/pages/home/app_body/views/feeds/helpers/mock_feeds.dart';

class FeedsWidget extends StatefulWidget {
    final AuthenticatedUser user;

    const FeedsWidget({super.key, required this.user});

    @override
    createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
    late final List<Feed> _feeds = [];

    // Adjust number of rows to retreive on request
    final int _countPerLoad = 10;

    bool _isLoading = false;
    int _currentOffset = 0;

    @override
    void initState() {
        super.initState();
        _loadFeeds();
    }

    Future<void> _loadFeeds() async {
        try {
            if (!mounted) return;

            setState(() {
                    _isLoading = true;
                }
            );

            List<Feed> fetchedFeeds =
                await DummyFeedDatabase().getFeeds(_currentOffset, _countPerLoad);

            if (fetchedFeeds.isNotEmpty) {
                setState(() {
                        _isLoading = false;
                        _feeds.addAll(fetchedFeeds);

                        _currentOffset += fetchedFeeds.length;
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
        return  InfiniteScrollListView(
            listOfData: _feeds, 
            currentOffset: _currentOffset, 
            isLoading: _isLoading, 
            loadMoreData: _loadFeeds,
            itemBuilder: (context, feed) => FeedContent(feedContent: feed), 
        );
    }
}
