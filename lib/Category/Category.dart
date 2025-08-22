class Category {
  final String name;
  final int number;
  //  final List<StorageRoom> storageRooms;

  Category({
    required this.name,
    required this.number,
    // List<StorageRoom>? storageRooms,
  }); // : storageRooms = storageRooms ?? []; // تأكد من أن القيمة ليست null
  // ignore: empty_constructor_bodies
  factory Category.fromJson(Map<dynamic, dynamic> json) {
    return Category(
            name: json['name'],
            number: json['number'], // التخصيص من الخريطة
    );
  }
}
