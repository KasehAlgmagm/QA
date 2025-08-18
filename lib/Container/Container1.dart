import 'package:flutter/material.dart';
import 'package:flutter_application_6/Category/Category.dart';
import 'package:flutter_application_6/Container/Container.dart';
import 'package:flutter_application_6/my_widget/RoomComparer.dart';
import 'package:flutter_application_6/my_widget/RoomManager.dart';
import 'package:flutter_application_6/prodact/ProductContainerScreen.dart'
    show ProductContainerScreen;
import 'package:flutter_application_6/storageRoom/StorageRoomScreen1.dart';

class ContainerScreen extends StatefulWidget {
  final Category? category; // تمرير كائن القسم

  final StorageRoom room;
  final List<ContainerItem> containers;

  ContainerScreen({
    required this.room,
    required this.containers,
    this.category,
  });

  @override
  _ContainerScreenState createState() => _ContainerScreenState();
}

class _ContainerScreenState extends State<ContainerScreen> {
  bool isMoving = false; // لتتبع حالة التحريك
  List<StorageRoom> allRooms = []; // لتخزين جميع الغرف
  StorageRoom? selectedRoom; // الغرفة المحددة
  List<ContainerItem> selectedContainers = []; // الكونتينرات المحددة

  @override
  void initState() {
    super.initState();
    allRooms = getAllRoomsForCategory(); // دالة لتحديث الغرف
  }

  List<StorageRoom> getAllRoomsForCategory() {
    // يجب عليك تعديل هذه الدالة لإرجاع جميع الغرف في القسم الحالي
    return []; // استبدل هذا بالشيفرة الصحيحة
  }

  void toggleMoveMode() {
    setState(() {
      isMoving = !isMoving;
      selectedContainers.clear(); // إعادة تعيين العناصر المحددة
      selectedRoom = null; // إعادة تعيين الغرفة المحددة
    });
  }

  void moveContainers() {
    if (selectedRoom != null) {
      // تحقق مما إذا كانت الغرفة المحددة هي نفس الغرفة الحالية
      if (selectedRoom!.id == widget.room.id) {
        // عرض رسالة خطأ
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('لا يمكنك النقل إلى نفس الغرفة!')),
        );
        return; // لا تقم بأي شيء
      }

      // إضافة الكونتينرات إلى الغرفة المحددة
      if (selectedRoom!.containers != null) {
        selectedRoom!.containers!.addAll(selectedContainers);
      } else {
        print("object");
      }

      if (RoomManager().mainRooms.isNotEmpty) {
        final mainRoom = RoomManager().mainRooms.firstWhere(
          (r) => r.id == widget.room.id,
          orElse:
              () => StorageRoom(
                id: 'default_room', // معرف غرفة افتراضية
                name: 'غرفة افتراضية',
                temperature: 20.0,
                humidity: 50.0,
                containers: [],
              ), // Throw an exception
        );
        if (mainRoom.containers != null) {
          mainRoom.containers!.removeWhere(
            (container) => selectedContainers.any(
              (selected) => selected.id == container.id,
            ),
          );
        } else {
          print(" mainRoom.containers==null");
        }

        // حذف الكونتينرات من القائمة في الشاشة الحالية
        widget.containers.removeWhere(
          (item) =>
              selectedContainers.any((selected) => selected.id == item.id),
        );

        toggleMoveMode();
      } else {
        // التعامل مع الحالة عندما تكون mainRooms فارغة
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('لا توجد غرف متاحة!')));
      }
    }
  }

  void toggleSelectAll() {
    setState(() {
      if (selectedContainers.length == widget.containers.length) {
        selectedContainers.clear(); // إلغاء تحديد الكل
      } else {
        selectedContainers = List.from(widget.containers); // تحديد الكل
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.room.name),
        backgroundColor: Colors.lightBlue,

        actions: [
          TextButton(
            onPressed: toggleMoveMode,
            child: Text(
              isMoving ? 'إلغاء' : 'نقل',
              style: TextStyle(
                color: isMoving ? Colors.red : Colors.black,
                fontSize: 25,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.containers.length,
              itemBuilder: (context, index) {
                final containerItem = widget.containers[index];

                return Container(
                  margin: EdgeInsets.all(8.0), // إضافة مسافة حول كل عنصر
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 4.0,
                    ), // إضافة الخط الأزرق
                    borderRadius: BorderRadius.circular(
                      30.0,
                    ), // جعل الزوايا مدورة
                  ),

                  child: Center(
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center, // توسيط العناصر في الصف
                        children: [
                          Expanded(
                            // استخدام Expanded لتوسيع النص ليملأ المساحة
                            child: Text(
                              containerItem.type,
                              textAlign: TextAlign.center, // توسيط النص
                              style: TextStyle(fontSize: 30), // تكبير حجم النص
                            ),
                          ),
                          SizedBox(width: 10), // إضافة مسافة بين النصوص
                          Expanded(
                            // استخدام Expanded لتوسيع النص ليملأ المساحة
                            child: Text(
                              'ID: ${containerItem.id}',
                              textAlign: TextAlign.center, // توسيط النص
                              style: TextStyle(fontSize: 30), // تكبير حجم النص
                            ),
                          ),
                        ],
                      ),
                      tileColor:
                          isMoving && selectedContainers.contains(containerItem)
                              ? Colors.lightBlueAccent
                              : null,
                      onTap: () {
                        if (isMoving) {
                          setState(() {
                            if (selectedContainers.contains(containerItem)) {
                              selectedContainers.remove(containerItem);
                            } else {
                              selectedContainers.add(containerItem);
                            }
                          });
                        } else {
                          // الانتقال إلى شاشة المنتجات
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ProductContainerScreen(
                                    containerItem: containerItem,
                                  ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          if (isMoving) ...[
            // عرض الأزرار في الأسفل عند تفعيل وضع النقل
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: toggleSelectAll,
                  child: Text(
                    selectedContainers.length == widget.containers.length
                        ? 'إلغاء تحديد الكل'
                        : 'تحديد الكل',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    RoomComparer roomComparer = RoomComparer(widget.category!);

                    List<StorageRoom> allRooms = roomComparer
                        .getRoomsInSameCategory(widget.room);
                    print(allRooms.length); // طباعة عدد الغرف
                    print(
                      "All rooms available for moving: ${allRooms.map((room) => room.name).toList()}",
                    );

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('اختر غرفة لنقل الكونتينرات'),
                          content: SizedBox(
                            height: 300,
                            width: 300,
                            child: ListView.builder(
                              itemCount:
                                  allRooms
                                      .length, // استخدام الغرف من كائن القسم
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(allRooms[index].name),
                                  onTap: () {
                                    setState(() {
                                      selectedRoom =
                                          allRooms[index]; // تحديد الغرفة المحددة
                                    });
                                    Navigator.of(context).pop(); // أغلق الحوار
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text('تحريك إلى غرفة'),
                ),
              ],
            ),
            if (selectedRoom != null) ...[
              Text('القاعة المحددة: ${selectedRoom!.name}'),
              ElevatedButton(
                onPressed: moveContainers,
                child: Text('قبول'), // زر "قبول"
              ),
            ],
          ],
        ],
      ),
    );
  }
}
