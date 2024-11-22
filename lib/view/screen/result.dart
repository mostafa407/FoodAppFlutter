import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todoappn/core/helper/sqflit_base.dart';
import 'package:todoappn/core/managers/color_manger.dart';
import 'package:todoappn/core/managers/font_manger.dart';
import 'package:todoappn/data/model/task_model.dart';

class result extends StatefulWidget {
  result({super.key, required this.tasksModel});
  TasksModel tasksModel;
  @override
  State<result> createState() => resultState();

}
class resultState extends State<result>{
  TextEditingController title=TextEditingController();
  TextEditingController description=TextEditingController();
  TextEditingController data=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: ColorManger.bottom_sheet,
        width: 1.sw,
        child: ElevatedButton(
            onPressed: () {
              ElevatedButton.styleFrom(

                  backgroundColor: ColorManger.primarycolor,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50.w,vertical: 50.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r)));
            },
            child: Text("Edit")),
      ),
      backgroundColor: ColorManger.bottom_sheet,
      // appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Checkbox(
                    value: widget.tasksModel.status == 'completed',
                    onChanged: (value) {

                      if(value!){

                        widget.tasksModel.status =='completed';
                        SqfliteHelper.instance.updateStatus(widget.tasksModel.id!, 'completed');
                      }else{
                        widget.tasksModel.status ='pending';
                        SqfliteHelper.instance.updateStatus(widget.tasksModel.id!, 'pending');
                      }
                    setState(() {

                    });
                      }
                    ,),
                  SizedBox(
                    width: 20.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        widget.tasksModel.title,
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      Text(
                        widget.tasksModel.description,
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  IconButton(onPressed: () {
                    showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          backgroundColor:  ColorManger.bottom_sheet,
                           content: Column(
                             mainAxisSize:MainAxisSize.min ,
                             children: [
                               TextFormField(
                                 onChanged: (value) {
                                   setState(() {
                                     widget.tasksModel.title=value;
                                   });
                                 },
                                 controller: title,
                                decoration: InputDecoration(
                                  hintText: 'title',
                                  hintStyle: TextStyle(
                                    color: Colors.white
                                  )
                                ),
                               ),
                               TextFormField(
                                 onChanged:  (value) {
                                   setState(() {
                                    widget.tasksModel.description=value;
                                   });
                                 },
                                 controller: description,
                                 decoration: InputDecoration(
                                     hintText: 'description'
                                     ,hintStyle: TextStyle(
                                     color: Colors.white
                                 )
                                 ),
                               ),
                               // TextFormField(
                               //   controller: data,
                               //   decoration: InputDecoration(
                               //       hintText: 'date'
                               //       ,hintStyle: TextStyle(
                               //       color: Colors.white
                               //   )
                               //   ),
                               // ),
                             ],
                           ),
                        );
                    },);

                  }, icon: Icon(Icons.edit))
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                      ),
                      Text(
                        "Task Time",
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      )
                    ],
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DateFormat.yMEd()
                            .format(DateTime.parse(widget.tasksModel.date)),
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: FontsManger.Font_Family),
                      ),
                    ),
                  )
                ],
              ),
              Row(children: [
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                  onTap: () async{
                    await SqfliteHelper.instance.deleteData(widget.tasksModel.id!);

                    Navigator.pop(context);

                  },
                  child: Row(children: [
                    Icon(Icons.delete,color: Colors.red,)
                    ,Text("Delete Task",style: TextStyle(fontSize: 20.sp,color: Colors.red),)

                  ],),)
              ],)
            ],
          ),
        ),
      ),
    );
  }
}

