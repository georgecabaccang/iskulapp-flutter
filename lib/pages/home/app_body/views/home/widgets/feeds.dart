import 'package:flutter/material.dart';
import 'package:school_erp/features/auth/auth_repository/schemas/user.dart';
import 'package:school_erp/pages/home/app_body/views/home/widgets/for_samples/mock_feeds.dart';

class FeedsWidget extends StatefulWidget {
  final AuthenticatedUser user;

  const FeedsWidget({super.key, required this.user});

  @override
  createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  final ScrollController _scrollController = ScrollController();
  late final List<DummyFeed> _feeds = [];

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
    setState(() {
      _isLoading = true;
    });

    List<DummyFeed> fetchedFeeds =
        await DummyFeedDatabase().getFeeds(_currentOffset, _countPerLoad);

    setState(() {
      _isLoading = false;
      _feeds.addAll(fetchedFeeds);

      if (fetchedFeeds.length < _countPerLoad) {
        _currentOffset += fetchedFeeds.length;
      } else {
        _currentOffset += _countPerLoad;
      }
    });
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

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_feeds[index].firstName} ${_feeds[index].lastName}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'This is the feed description for post #$index.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[300],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          _feeds[index].imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.favorite, color: Colors.red),
                            const SizedBox(width: 4),
                            Text(
                              '${_feeds[index].likes} likes',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            TextButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.thumb_up, color: Colors.blue),
                              label: const Text('Like'),
                            ),
                            const SizedBox(width: 8),
                            TextButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.comment, color: Colors.grey),
                              label: const Text('Comment'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              _showAddPostDialog(context);
            },
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  void _showAddPostDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Enter your post'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Post'),
            ),
          ],
        );
      },
    );
  }
}

//
