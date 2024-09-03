class User {
  final int id;
  final String name;
  final String imageUrl;

  User({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
}

// YOU - current user
final User currentUser = User(
  id: 0,
  name: 'Nick Fury',
  imageUrl:
      'https://static.vecteezy.com/system/resources/thumbnails/004/511/281/small/default-avatar-photo-placeholder-profile-picture-vector.jpg',
);

// USERS
final User ironMan = User(
  id: 1,
  name: 'Iron Man',
  imageUrl:
      'https://static.vecteezy.com/system/resources/thumbnails/004/511/281/small/default-avatar-photo-placeholder-profile-picture-vector.jpg',
);
final User captainAmerica = User(
  id: 2,
  name: 'Captain America',
  imageUrl:
      'https://static.vecteezy.com/system/resources/thumbnails/004/511/281/small/default-avatar-photo-placeholder-profile-picture-vector.jpg',
);
final User hulk = User(
  id: 3,
  name: 'Hulk',
  imageUrl:
      'https://static.vecteezy.com/system/resources/thumbnails/004/511/281/small/default-avatar-photo-placeholder-profile-picture-vector.jpg',
);
final User scarletWitch = User(
  id: 4,
  name: 'Scarlet Witch',
  imageUrl:
      'https://static.vecteezy.com/system/resources/thumbnails/004/511/281/small/default-avatar-photo-placeholder-profile-picture-vector.jpg',
);
final User spiderMan = User(
  id: 5,
  name: 'Spider Man',
  imageUrl:
      'https://static.vecteezy.com/system/resources/thumbnails/004/511/281/small/default-avatar-photo-placeholder-profile-picture-vector.jpg',
);
final User blackWindow = User(
  id: 6,
  name: 'Black Widow',
  imageUrl:
      'https://static.vecteezy.com/system/resources/thumbnails/004/511/281/small/default-avatar-photo-placeholder-profile-picture-vector.jpg',
);
final User thor = User(
  id: 7,
  name: 'Thor',
  imageUrl:
      'https://static.vecteezy.com/system/resources/thumbnails/004/511/281/small/default-avatar-photo-placeholder-profile-picture-vector.jpg',
);
final User captainMarvel = User(
  id: 8,
  name: 'Captain Marvel',
  imageUrl:
      'https://static.vecteezy.com/system/resources/thumbnails/004/511/281/small/default-avatar-photo-placeholder-profile-picture-vector.jpg',
);
