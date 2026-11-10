import 'package:flutter/material.dart';

import '../model/userdata.dart';
import '../model/userpost.dart';
import '../model/usercomment.dart';

// Post detail page: opened when you tap a post.
class ProfileView extends StatefulWidget {
  const ProfileView({
    super.key,
    required this.userPost,
    required this.userdata,
  });

  final Userpost userPost;
  final Userdata userdata;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController commentController = TextEditingController();
  Userpost get userPost => widget.userPost;
  Userdata get userData => widget.userdata;

  static const nametxtstyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void addComment() {
    final content = commentController.text.trim();
    if (content.isEmpty) return;

    setState(() {
      userPost.comments.add(
        Usercomment(
          commenterImg: userData.myUserAccount.img,
          commenterName: userData.myUserAccount.name,
          commentTime: 'Just now',
          commentContent: content,
        ),
      );
      userPost.numcomments++;
    });
    commentController.clear();
  }

  Widget commenters(Userpost userPost) => Container(
    color: const Color(0xFFFFF7FE),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${userPost.comments.length}'),
        const SizedBox(height: 10),
        const Row(
          children: [Text('All Comments'), Icon(Icons.arrow_drop_down)],
        ),
      ],
    ),
  );

  // one comment: avatar, grey bubble, "time  Like  Reply"
  Widget userpostdetails(Usercomment userComment) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(userComment.commenterImg),
          radius: 16,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userComment.commenterName, style: nametxtstyle),
                  Text(userComment.commentContent),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  userComment.commentTime,
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(width: 12),
                const Text('Like', style: TextStyle(fontSize: 12)),
                const SizedBox(width: 12),
                const Text('Reply', style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  Widget buttons(Userpost userPost) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Divider(color: Colors.grey),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: userPost.isLiked ? Colors.grey : Colors.blue,
              ),
              onPressed: () {},
              icon: const Icon(Icons.thumb_up, size: 20),
              label: const Text('Like'),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              onPressed: () {},
              icon: const Icon(Icons.chat_bubble, size: 20),
              label: const Text('Comment'),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              onPressed: () {},
              icon: const Icon(Icons.share, size: 20),
              label: const Text('Share'),
            ),
          ],
        ),
      ),
      const Divider(color: Colors.grey),
    ],
  );

  Widget userline(Userpost userPost) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CircleAvatar(
          backgroundImage: AssetImage(userPost.userimg),
          radius: 20,
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(userPost.username, style: nametxtstyle),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(userPost.time),
              const Text('.'),
              const Icon(Icons.group, size: 15, color: Colors.grey),
            ],
          ),
        ],
      ),
    ],
  );

  Widget postimage(Userpost userPost) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(children: [Text(userPost.postcontent)]),
        const SizedBox(height: 15),
        Container(
          height: 350,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(userPost.posting),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          userline(userPost),
          postimage(userPost),
          buttons(userPost),
          commenters(userPost),
          ...userPost.comments.map(userpostdetails),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('comment-input'),
                    controller: commentController,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => addComment(),
                    decoration: const InputDecoration(
                      hintText: 'Write a comment...',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                IconButton(
                  key: const Key('submit-comment'),
                  onPressed: addComment,
                  icon: const Icon(Icons.send),
                  tooltip: 'Post comment',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
