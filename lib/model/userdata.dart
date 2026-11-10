import 'friend.dart';
import 'usercomment.dart';
import 'userpost.dart';
import 'account.dart';

class Userdata {
  List<Userpost> userList = [
    Userpost(
      userimg: 'assets/person1.jpg',
      username: 'Alice',
      time: '2 hrs ago',
      postcontent: 'Had a great day at the beach!',
      posting: 'assets/pavlova.jpg',
      numcomments: 24,
      numshare: '5',
      isLiked: false,
      comments: [
        Usercomment(
          commenterImg: 'assets/person2.jpg',
          commenterName: 'Bob',
          commentTime: '1 hr ago',
          commentContent: 'Looks fun!',
        ),
        Usercomment(
          commenterImg: 'assets/person3.jpg',
          commenterName: 'Charlie',
          commentTime: '30 mins ago',
          commentContent: 'Wish I was there!',
        ),
        Usercomment(
          commenterImg: 'assets/person4.jpg',
          commenterName: 'Diana',
          commentTime: '15 mins ago',
          commentContent: 'Great photo!',
        ),
        Usercomment(
          commenterImg: 'assets/person5.jpg',
          commenterName: 'Ethan',
          commentTime: '10 mins ago',
          commentContent: 'Looks delicious!',
        ),
        Usercomment(
          commenterImg: 'assets/person6.jpg',
          commenterName: 'Michael',
          commentTime: '5 mins ago',
          commentContent: 'Save me a slice!',
        ),
      ],
    ),
    Userpost(
      userimg: 'assets/person2.jpg',
      username: 'Bob',
      time: '3 hrs ago',
      postcontent: 'Loving the new cafe in town.',
      posting: 'assets/pavlova.jpg',
      numcomments: 18,
      numshare: '3',
      isLiked: true,
    ),
    Userpost(
      userimg: 'assets/person3.jpg',
      username: 'Charlie',
      time: '5 hrs ago',
      postcontent: 'Just finished a 10k run!',
      posting: 'assets/pavlova.jpg',
      numcomments: 30,
      numshare: '7',
      isLiked: false,
    ),
    Userpost(
      userimg: 'assets/person4.jpg',
      username: 'Diana',
      time: '5 hrs ago',
      postcontent: 'Just finished a 10k run!',
      posting: 'assets/pavlova.jpg',
      numcomments: 30,
      numshare: '7',
      isLiked: false,
    ),
  ];

  List<Friend> friendList = [
    Friend(img: 'assets/person1.jpg', name: 'Alice'),
    Friend(img: 'assets/person2.jpg', name: 'Bob'),
    Friend(img: 'assets/person3.jpg', name: 'Charlie'),
    Friend(img: 'assets/person4.jpg', name: 'Diana'),
    Friend(img: 'assets/person5.jpg', name: 'Ethan'),
    Friend(img: 'assets/person6.jpg', name: 'Michael'),
  ];

  Account myUserAccount = Account(
    name: 'Joshua Regidor',
    email: 'joshuaregidor@example.com',
    img: 'assets/person1.jpg',
    numFollowers: '1 Million',
    numPosts: '350',
    numFollowing: '500',
    numFriends: '200',
  );
}
