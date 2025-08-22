class StorageRoom {
  final String id; // معرف الغرفة
  final String name; // اسم الغرفة
  final double temperature; // درجة الحرارة
  final double humidity; // درجة الرطوبة

  StorageRoom({
    required this.id,
    required this.name,
    required this.temperature,
    required this.humidity,
  });

  // دالة لتحويل البيانات من JSON إلى كائن StorageRoom
  factory StorageRoom.fromJson(Map<String, dynamic> json) {
    return StorageRoom(
      id: json['id'], // تعيين معرف الغرفة
      name: json['name'], // تعيين اسم الغرفة
      temperature: (json['temperature'] as num).toDouble(), // تعيين درجة الحرارة
      humidity: (json['humidity'] as num).toDouble(), // تعيين درجة الرطوبة
    );
  }
}