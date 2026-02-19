import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/app_colours.dart';
import 'package:glint_frontend/design/common/app_theme.dart';
import 'package:glint_frontend/utils/date_and_time_extensions.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatChannelTile extends StatefulWidget {
  const ChatChannelTile({
    super.key,
    required this.channel,
    required this.currentUserId,
    required this.onTap,
  });

  final Channel channel;
  final String? currentUserId;
  final VoidCallback onTap;

  @override
  State<ChatChannelTile> createState() => _ChatChannelTileState();
}

class _ChatChannelTileState extends State<ChatChannelTile> {
  User? _oppositeUser;
  bool _isResolvingUser = false;

  @override
  void initState() {
    super.initState();
    _resolveOppositeUser();
  }

  Future<void> _resolveOppositeUser() async {
    final currentUserId = widget.currentUserId;
    if (currentUserId == null) return;

    // Fast path — member.user is already enriched
    final cachedUser = widget.channel.state?.members
        .where((m) => m.userId != currentUserId)
        .firstOrNull
        ?.user;

    if (cachedUser != null) {
      // Only update state if the widget is still mounted
      if (mounted) setState(() => _oppositeUser = cachedUser);
      return;
    }

    // Slow path — member.user is null; hit the API
    if (_isResolvingUser) return;
    _isResolvingUser = true;

    try {
      final result = await widget.channel.queryMembers(
        filter: Filter.notEqual('id', currentUserId),
        pagination: const PaginationParams(limit: 1),
      );
      final fetchedUser = result.members.firstOrNull?.user;
      if (mounted && fetchedUser != null) {
        setState(() => _oppositeUser = fetchedUser);
      }
    } catch (_) {
      // Silently fail — tile will render with fallback values
    } finally {
      _isResolvingUser = false;
    }
  }

  _TileData get _tileData {
    final messages = widget.channel.state?.messages ?? [];
    final unreadCount = widget.channel.state?.unreadCount ?? 0;

    if (messages.isEmpty) {
      return _TileData.empty();
    }

    final lastMessage = messages.last;
    final isMedia = lastMessage.attachments.isNotEmpty;
    final isUnreadFromOther =
        lastMessage.user?.id != widget.currentUserId && unreadCount > 0;

    return _TileData(
      subtitleText: isMedia ? 'Checkout this Image' : (lastMessage.text ?? ''),
      lastMessageDate: lastMessage.createdAt,
      showYourTurn: isUnreadFromOther,
      isEmpty: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = _tileData;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 20.0,
      ),
      leading: _AvatarWidget(imageUrl: _oppositeUser?.image),
      title: Text(
        _oppositeUser?.name ?? 'User',
        style: AppTheme.simpleBodyText.copyWith(color: AppColours.black),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        data.subtitleText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTheme.simpleText.copyWith(color: AppColours.darkGray),
      ),
      trailing: _TrailingWidget(
        showYourTurn: data.showYourTurn,
        lastMessageDate: data.lastMessageDate,
      ),
      onTap: widget.onTap,
    );
  }
}

class _AvatarWidget extends StatelessWidget {
  const _AvatarWidget({this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.0,
      width: 48.0,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: FadeInImage.assetNetwork(
          placeholder: 'lib/assets/images/temp_place_holder.png',
          // Empty string will fail gracefully into errorBuilder
          image: imageUrl ?? '',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'lib/assets/images/temp_place_holder.png',
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}

class _TrailingWidget extends StatelessWidget {
  const _TrailingWidget({
    required this.showYourTurn,
    this.lastMessageDate,
  });

  final bool showYourTurn;
  final DateTime? lastMessageDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (showYourTurn) const _YourTurnBadge(),
          const Gap(8.0),
          if (lastMessageDate != null)
            Text(
              lastMessageDate!.toChatTimestamp(),
              style: AppTheme.smallBodyText.copyWith(
                color: AppColours.darkGray,
              ),
            ),
        ],
      ),
    );
  }
}

class _YourTurnBadge extends StatelessWidget {
  const _YourTurnBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        'Your Turn',
        style: AppTheme.simpleText.copyWith(
          fontSize: 10.0,
          fontWeight: FontWeight.w600,
          color: AppColours.white,
        ),
      ),
    );
  }
}

class _TileData {
  const _TileData({
    required this.subtitleText,
    required this.showYourTurn,
    required this.isEmpty,
    this.lastMessageDate,
  });

  factory _TileData.empty() => const _TileData(
    subtitleText: 'Make your first move,',
    showYourTurn: true,
    isEmpty: true,
  );

  final String subtitleText;
  final bool showYourTurn;
  final bool isEmpty;
  final DateTime? lastMessageDate;
}