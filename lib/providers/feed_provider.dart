import 'package:flutter/material.dart';
import 'package:shandada/models/feed.dart';
import 'package:shandada/constants/mock_data.dart';

class FeedProvider extends ChangeNotifier {
  late List<Feed> _feeds;

  FeedProvider() {
    _feeds = List.from(MockData.feeds);
  }

  List<Feed> get feeds => _feeds;

  void addFeed(Feed feed) {
    _feeds.insert(0, feed);
    notifyListeners();
  }

  void removeFeed(String feedId) {
    _feeds.removeWhere((feed) => feed.id == feedId);
    notifyListeners();
  }

  void updateFeed(Feed updatedFeed) {
    final index = _feeds.indexWhere((feed) => feed.id == updatedFeed.id);
    if (index != -1) {
      _feeds[index] = updatedFeed;
      notifyListeners();
    }
  }

  void likeFeed(String feedId) {
    final index = _feeds.indexWhere((feed) => feed.id == feedId);
    if (index != -1) {
      final feed = _feeds[index];
      _feeds[index] = Feed(
        id: feed.id,
        userName: feed.userName,
        userAvatar: feed.userAvatar,
        rating: feed.rating,
        ratingLabel: feed.ratingLabel,
        title: feed.title,
        description: feed.description,
        images: feed.images,
        category: feed.category,
        categoryEmoji: feed.categoryEmoji,
        likes: feed.likes + 1,
        comments: feed.comments,
        createdAt: feed.createdAt,
        isBookmarked: feed.isBookmarked,
        bookmarkedBy: feed.bookmarkedBy,
      );
      notifyListeners();
    }
  }

  void toggleBookmark(String feedId, String currentUserName) {
    final index = _feeds.indexWhere((feed) => feed.id == feedId);
    if (index != -1) {
      final feed = _feeds[index];
      final isCurrentlyBookmarked = feed.isBookmarked && feed.bookmarkedBy == currentUserName;
      
      _feeds[index] = feed.copyWith(
        isBookmarked: !isCurrentlyBookmarked,
        bookmarkedBy: !isCurrentlyBookmarked ? currentUserName : null,
      );
      notifyListeners();
    }
  }

  List<Feed> getBookmarkedFeeds(String userName) {
    return _feeds
        .where((feed) => feed.isBookmarked && feed.bookmarkedBy == userName)
        .toList();
  }
}
