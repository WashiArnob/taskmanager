// import 'package:flutter/material.dart';
// import 'package:taskmanager/api/apiClient.dart';
// import 'package:taskmanager/Style/Style.dart';
// import 'TaskList.dart';
// import 'package:get/get.dart';
//
// class newTaskList extends StatefulWidget {
//   const newTaskList({Key? key}) : super(key: key);
//
//   @override
//   State<newTaskList> createState() => _newTaskListState();
// }
//
// class _newTaskListState extends State<newTaskList> {
//   List TaskItems=[];
//   bool Loading=true;
//   String Status="New";
//
//   @override
//   void initState(){
//     CallData();
//     super.initState();
//   }
//
//   CallData() async{
//     var data= await TaskListRequest("New");
//     setState(() {
//       Loading=false;
//       TaskItems=data;
//     });
//   }
//
//   UpdateStatus(id) async{
//     setState(() {Loading=true;});
//     await TaskUpdateRequest(id,Status);
//     await CallData();
//     setState(() {Status = "New";});
//   }
//
//
//   DeleteItem(id) async{
//     showDialog(
//         context: context,
//         builder: (BuildContext context){
//           return AlertDialog(
//             title: Text("Delete !"),
//             content: Text("Onece delete, you can't get it back"),
//             actions: [
//               OutlinedButton(onPressed: () async {
//                 Navigator.pop(context);
//                 setState(() {Loading=true;});
//                 await TaskDeleteRequest(id);
//                 await CallData();
//               }, child: Text('Yes')),
//               OutlinedButton(onPressed: (){
//                 Navigator.pop(context);
//               }, child: Text('No')),
//             ],
//           );
//         }
//     );
//   }
//
//   StatusChange(id) async{
//     showModalBottomSheet(context: context,
//         builder: (context){
//           return StatefulBuilder(
//               builder: (BuildContext context,StateSetter setState){
//                 return Container(
//                   padding: EdgeInsets.all(30),
//                   height: 360,
//                   child:Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       RadioListTile(title: Text("New"), value: "New", groupValue: Status,
//                         onChanged: (value){
//                           setState(() {
//                             Status = value.toString();
//                           });
//                         },
//                       ),
//                       RadioListTile(title: Text("Progress"), value: "Progress", groupValue: Status,
//                         onChanged: (value){
//                           setState(() {
//                             Status = value.toString();
//                           });
//                         },
//                       ),
//                       RadioListTile(title: Text("Completed"), value: "Completed", groupValue: Status,
//                         onChanged: (value){
//                           setState(() {
//                             Status = value.toString();
//                           });
//                         },
//                       ),
//                       RadioListTile(title: Text("Canceled"), value: "Canceled", groupValue: Status,
//                         onChanged: (value){
//                           setState(() {
//                             Status = value.toString();
//                           });
//                         },
//                       ),
//                       Container(child: ElevatedButton(
//                         style: AppButtonStyle(),
//                         child: SuccessButtonChild('Confirm'),
//                         onPressed: (){
//                           Navigator.pop(context);
//                           UpdateStatus(id);
//                         },
//                       ),)
//                     ],
//                   ),
//                 );
//               }
//           );
//         }
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Loading?(Center(child: CircularProgressIndicator())):RefreshIndicator(
//         onRefresh: () async {
//           await CallData();
//         },
//         child: TaskList(TaskItems,DeleteItem,StatusChange)
//     );
//   }
// }

///with getx

import 'package:flutter/material.dart';
import 'package:taskmanager/api/apiClient.dart';
import 'package:taskmanager/Style/Style.dart';
import 'package:get/get.dart';
import 'TaskList.dart';

class TaskController extends GetxController {
  var taskItems = [].obs;
  var loading = true.obs;
  var status = "New".obs;

  // Fetch task data
  Future<void> callData() async {
    loading(true);
    var data = await TaskListRequest("New");
    taskItems.assignAll(data);
    loading(false);
  }

  // Update task status
  Future<void> updateStatus(String id) async {
    loading(true);
    await TaskUpdateRequest(id, status.value);
    await callData();
    status.value = "New";
  }

  // Delete task item
  Future<void> deleteItem(String id) async {
    loading(true);
    await TaskDeleteRequest(id);
    await callData();
  }

  // Change task status
  void statusChange(String newStatus) {
    status.value = newStatus;
  }

  @override
  void onInit() {
    callData();
    super.onInit();
  }
}

class NewTaskList extends StatelessWidget {
  final TaskController controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.loading.value
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: () async {
          await controller.callData();
        },
        child: TaskList(
          controller.taskItems,
              (id) => _showDeleteDialog(context, id),
              (id) => _showStatusChangeSheet(context, id),
        ),
      );
    });
  }

  // Show dialog to confirm deletion
  void _showDeleteDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete!"),
          content: Text("Once deleted, you can't get it back"),
          actions: [
            OutlinedButton(
              onPressed: () async {
                Get.back();
                await controller.deleteItem(id);
              },
              child: Text('Yes'),
            ),
            OutlinedButton(
              onPressed: () {
                Get.back();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  // Show bottom sheet to change status
  void _showStatusChangeSheet(BuildContext context, String id) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(30),
              height: 360,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RadioListTile(
                    title: Text("New"),
                    value: "New",
                    groupValue: controller.status.value,
                    onChanged: (value) {
                      controller.statusChange(value.toString());
                    },
                  ),
                  RadioListTile(
                    title: Text("Progress"),
                    value: "Progress",
                    groupValue: controller.status.value,
                    onChanged: (value) {
                      controller.statusChange(value.toString());
                    },
                  ),
                  RadioListTile(
                    title: Text("Completed"),
                    value: "Completed",
                    groupValue: controller.status.value,
                    onChanged: (value) {
                      controller.statusChange(value.toString());
                    },
                  ),
                  RadioListTile(
                    title: Text("Canceled"),
                    value: "Canceled",
                    groupValue: controller.status.value,
                    onChanged: (value) {
                      controller.statusChange(value.toString());
                    },
                  ),
                  Container(
                    child: ElevatedButton(
                      style: AppButtonStyle(),
                      child: SuccessButtonChild('Confirm'),
                      onPressed: () {
                        Navigator.pop(context);
                        controller.updateStatus(id);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
