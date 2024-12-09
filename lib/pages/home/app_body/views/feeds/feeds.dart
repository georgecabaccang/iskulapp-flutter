import 'package:flutter/material.dart';
import 'package:school_erp/features/auth/auth_repository/schemas/user.dart';
import 'package:school_erp/pages/home/app_body/views/feeds/widgets/feed_content.dart';
import 'package:school_erp/pages/home/app_body/views/feeds/helpers/mock_feeds.dart';
import 'package:school_erp/pages/home/app_body/views/feeds/widgets/feeds_modal_form.dart';

class FeedsWidget extends StatefulWidget {
    final AuthenticatedUser user;

    const FeedsWidget({super.key, required this.user});

    @override
    createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
    final ScrollController _scrollController = ScrollController();
    late final List<Feed> _feeds = [];

    // Adjust number of rows to retreive on request
    final int _countPerLoad = 10;

    bool _isLoading = false;
    int _currentOffset = 0;

    @override
    void initState() {
        super.initState();
        _scrollController.addListener(_scrollListener);
        _loadFeeds();
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
                _loadFeeds();
            }
        }
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
        return Stack(
            children: [
                ListView.builder(
                    controller: _scrollController,
                    itemCount: _currentOffset + 1,
                    itemBuilder: (BuildContext context, int index) {
                        if (index == _feeds.length) {
                            return _isLoading
                                ? Center(child: CircularProgressIndicator())
                                : SizedBox.shrink(); // REMINDER: Use in learn view also
                        }
                        return FeedContent(feedContent: _feeds[index]);
                    },
                ),
                FeedsModalForm()
            ],
        );
    }
}
