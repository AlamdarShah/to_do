import 'package:flutter/material.dart';
import 'package:todo_application/repository/DBHelper.dart';
import 'model/model.dart';

class DisplayItem extends StatefulWidget {
  static List listFromDatabase = [];
  DisplayItem({super.key});
  @override
  State<DisplayItem> createState() => _DisplayItemState();
}
class _DisplayItemState extends State<DisplayItem> {
  displayItemsFromDatabase() async {
    List ttdatabaseItems = await DBhelper.readData();
    setState(() {
      DisplayItem.listFromDatabase = [];
      if (ttdatabaseItems.isNotEmpty) {
        ttdatabaseItems.forEach((element) {
          MyItem myItem = MyItem(id: 0, name: "", description: "");
          myItem.id = element['id'];
          myItem.name = element['name'];
          myItem.description = element['description'];
          DisplayItem.listFromDatabase.add(myItem);
        });
      }
    });
  }
  @override
  void initState() {
    super.initState();
    displayItemsFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To-do Items"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: DisplayItem.listFromDatabase.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(DisplayItem.listFromDatabase[index].name),
              subtitle: Text(DisplayItem.listFromDatabase[index].description),
              trailing: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.red,
                child: IconButton(
                  color: Colors.white,
                  //padding: const EdgeInsets.all(20),
                  iconSize: 33,
                  icon: const Icon(Icons.delete_outline),
                  alignment: Alignment.center,
                  onPressed: () async {
                    await DBhelper.deleteData(
                        DisplayItem.listFromDatabase[index]);
                    displayItemsFromDatabase();
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
