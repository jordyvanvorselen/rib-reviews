import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rib_reviews/domain/models/event.dart';
import 'package:rib_reviews/domain/models/reaction.dart';
import 'package:rib_reviews/domain/models/review.dart';
import 'package:rib_reviews/domain/models/user.dart';
import 'package:rib_reviews/domain/utils/responsive.dart';
import 'package:rib_reviews/presentation/components/alerts/review_alert.dart';
import 'package:rib_reviews/presentation/components/app_bar/custom_app_bar.dart';
import 'package:rib_reviews/presentation/components/review/review_header.dart';
import 'package:rib_reviews/presentation/components/review/user_review.dart';
import 'package:rib_reviews/providers.dart';

class ReviewScreen extends ConsumerStatefulWidget {
  final Event event;
  final User currentUser;

  const ReviewScreen({Key? key, required this.event, required this.currentUser})
      : super(key: key);

  @override
  ReviewScreenState createState() => ReviewScreenState();
}

class ReviewScreenState extends ConsumerState<ReviewScreen> {
  @override
  void initState() {
    ref.read(Providers.reactionsController).fetchReactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onReactionTap(Reaction reaction) {
      setState(() {
        ref.watch(Providers.reactionsController).toggleReaction(
              reaction.emoji,
              reaction.review,
              widget.currentUser,
            );
      });
    }

    void onReaction(Review review) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
                height: 400,
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) {
                    setState(() {
                      ref.watch(Providers.reactionsController).toggleReaction(
                            emoji.emoji,
                            review,
                            widget.currentUser,
                          );

                      Navigator.pop(context);
                    });
                  },
                  config: Config(
                    columns: Responsive.isWeb(context) ? 24 : 8,
                    emojiSizeMax: 24,
                    enableSkinTones: false,
                    showRecentsTab: true,
                    buttonMode: ButtonMode.CUPERTINO,
                  ),
                ));
          });
    }

    return Scaffold(
      appBar: CustomAppBar(
        user: widget.currentUser,
        context: context,
        showLogo: Responsive.isWeb(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ReviewAlert().show(
            context,
            widget.event,
            (double rating, String text) async {
              Review review =
                  await ref.watch(Providers.reviewSaveServiceProvider).save(
                        rating,
                        text,
                        widget.currentUser,
                        widget.event,
                      );

              setState(() {
                ref
                    .read(Providers.eventsController)
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
          padding: const EdgeInsets.symmetric(vertical: 25),
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
                            reactions: ref
                                .watch(Providers.reactionsController)
                                .reactions
                                .where((r) => r.review.id == review.id)
                                .toList(),
                            currentUser: widget.currentUser,
                            onReactionTap: onReactionTap,
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
