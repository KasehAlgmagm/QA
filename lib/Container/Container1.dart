import 'package:flutter/material.dart';
import 'package:flutter_application_6/Container/Container.dart';
import 'package:flutter_application_6/apis/connect/ContainerManager.dart';
import 'package:flutter_application_6/apis/move_containers.dart';
import 'package:flutter_application_6/apis/move_to_position.dart';
import 'package:flutter_application_6/product/ProductContainerScreen.dart'
    show ProductContainerScreen;
import 'package:flutter_application_6/static_classes/show_sections_of_container_in_place_data.dart';
import 'package:flutter_application_6/storageRoom/StorageRoomScreen1.dart';

class ContainerScreen extends StatefulWidget {
  //final Category? category; // تمرير كائن القسم

  final StorageRoom storageRoom;
  //final List<ContainerItem> containers;

  ContainerScreen({
    required this.storageRoom,
    //required this.containers,
    //this.category,
  });

  @override
  _ContainerScreenState createState() => _ContainerScreenState();
}

class _ContainerScreenState extends State<ContainerScreen> {
  ContainerManager contaierManager = ContainerManager();
  bool isMoving = false; // لتتبع حالة التحريك
  //List<StorageRoom> allRooms = []; // لتخزين جميع الغرف
  StorageRoom? selectedRoom; // الغرفة المحددة
  List<ContainerItem> selectedContainers = []; // الكونتينرات المحددة

  @override
  void initState() {
    super.initState();
    contaierManager.loadContainers(widget.storageRoom.id);
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
      if (selectedRoom!.id == widget.storageRoom.id) {
        // عرض رسالة خطأ
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('لا يمكنك النقل إلى نفس الغرفة!')),
        );
        return; // لا تقم بأي شيء
      }

      // حذف الحاويات من القائمة في الشاشة الحالية
      // widget.containers.removeWhere(
      //   (item) => selectedContainers.any((selected) => selected.id == item.id),
      // );

      // التعامل مع النقل باستخدام MoveToPosition أو MoveContainers
      if (selectedContainers.length == 1) {
        // عندما تكون هناك حاوية واحدة، استخدم MoveToPosition
        MoveToPosition moveToPosition = MoveToPosition();
        moveToPosition.moveToPositionMethod(
          containerId: selectedContainers.first.id,
          postionID: selectedRoom!.id,
          why: 'نقل تلقائي',
        );
      } else {
        // عندما تكون هناك عدة حاويات، استخدم MoveContainers
        MoveContainers moveContainers = MoveContainers();
        List<int> containerIds =
            selectedContainers.map((item) => item.id).toList();

        moveContainers.moveContainersMethod(
          destinationStorageMediaId: selectedRoom!.id,
          why: 'نقل تلقائي',
          containersIdes: containerIds,
        );
      }

      toggleMoveMode();
    }
  }

  void toggleSelectAll() {
    setState(() {
      if (selectedContainers.length == contaierManager.containers.length) {
        selectedContainers.clear(); // إلغاء تحديد الكل
      } else {
        selectedContainers = List.from(
          contaierManager.containers,
        ); // تحديد الكل
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.storageRoom.name),
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
              itemCount: contaierManager.containers.length,
              itemBuilder: (context, index) {
                final containerItem = contaierManager.containers[index];

                return Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 4.0),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              containerItem.type,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'ID: ${containerItem.id}',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: toggleSelectAll,
                  child: Text(
                    selectedContainers.length ==
                            contaierManager.containers.length
                        ? 'إلغاء تحديد الكل'
                        : 'تحديد الكل',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // إظهار الحوار لاختيار الغرفة
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
                                  ShowSectionsOfContainerInPlaceData
                                      .showSectionsOfContainerInPlaceMap
                                      .length,
                              itemBuilder: (context, index) {
                                final room = ShowSectionsOfContainerInPlaceData
                                    .showSectionsOfContainerInPlaceMap
                                    .keys
                                    .elementAt(index);
                                return ListTile(
                                  title: Text(room),
                                  onTap: () {
                                    setState(() {
                                      selectedRoom =
                                          room; // تحديد الغرفة المحددة
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
          ],
        ],
      ),
    );
  }
}
