import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rib_reviews/components/review_alert.dart';
import 'package:rib_reviews/components/review_header.dart';
import 'package:rib_reviews/components/user_review.dart';
import 'package:rib_reviews/models/event.dart';
import 'package:rib_reviews/models/reaction.dart';
import 'package:rib_reviews/models/review.dart';
import 'package:rib_reviews/models/user.dart';
import 'package:rib_reviews/providers/providers.dart';
import 'package:rib_reviews/utils/common.dart';

class ReviewScreen extends ConsumerStatefulWidget {
  final Event event;
  final User user;

  const ReviewScreen({Key? key, required this.event, required this.user})
      : super(key: key);

  @override
  ReviewScreenState createState() => ReviewScreenState();
}

class ReviewScreenState extends ConsumerState<ReviewScreen> {
  List<Reaction> reactions = [];

  @override
  Widget build(BuildContext context) {
    void onReaction(Review review) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
                height: 400,
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) {
                    setState(() {
                      reactions.add(Reaction(
                        emoji: emoji.emoji,
                        users: [widget.user],
                        review: review,
                      ));
                    });
                  },
                  config: const Config(
                    columns: 8,
                    emojiSizeMax: 24,
                    enableSkinTones: false,
                    showRecentsTab: true,
                    buttonMode: ButtonMode.CUPERTINO,
                  ),
                ));
          });
    }

    return Scaffold(
      appBar: Common.appBar(widget.user, context, showLogo: false),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ReviewAlert().show(
            context,
            widget.event,
            (rating, text) async {
              Review review =
                  await ref.watch(Providers.reviewSaveServiceProvider).save(
                        rating,
                        text,
                        widget.user,
                        widget.event,
                      );

              setState(() {
                ref
                    .read(Providers.eventsProvider)
                    .addReview(review, widget.event);
              });

              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.star, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              ReviewHeader(widget: widget),
              const Divider(),
              Expanded(
                child: ListView(
                  children: widget.event.reviews
                      .map((review) => UserReview(
                            review: review,
                            onReaction: () => onReaction(review),
                            reactions: reactions,
                          ))
                      .fold<List<Widget>>(
                    [],
                    (value, element) {
                      value.add(const SizedBox(height: 20));
                      value.add(element);

                      return value;
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
