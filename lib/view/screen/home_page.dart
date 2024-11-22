import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todoappn/core/helper/sqflit_base.dart';
import 'package:todoappn/core/managers/color_manger.dart';
import 'package:todoappn/core/managers/font_manger.dart';
import 'package:todoappn/core/managers/image_manger.dart';
import 'package:todoappn/data/model/task_model.dart';
import 'package:todoappn/main.dart';
import 'package:todoappn/view/screen/result.dart';
import 'package:intl/intl.dart';


class home extends StatefulWidget {
  const home({super.key});


  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  bool isCompleted = false;
  List<TasksModel> tasks = [];
  DateTime selectDate = DateTime.now();
  DateTime selectTime = DateTime.now();
  TextEditingController Text1 = TextEditingController();
  TextEditingController Text2 = TextEditingController();

  @override
  void initState() {
    getTask();
    super.initState();
  }


  Future<void> getTask() async {
    tasks = await SqfliteHelper.instance.getDataFromDatabase();
    setState(() {
      tasks.forEach((e) {
        print(e.toMap());
      }
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorManger.primarycolor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
          color: Colors.white,
        ),
        backgroundColor: ColorManger.primarycolor,
        centerTitle: true,
        title: Text(
          "index",
          style: TextStyle(
              fontFamily: FontsManger.Font_Family,
              fontSize: 20.sp,
              color: Colors.white),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage(AssetsManger.profile),
          )
        ],
      ),
      body:
      SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child:
        tasks.isNotEmpty ? ListView.builder(
          // TimeOfDate time=TimeOfDay(hour: hour, minute: minute)
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            // TimeOfDay time=TimeOfDay.fromDateTime(DateTime.parse(
            //   " ${tasks[index].date.split(' ')[0] } ${ tasks[index].date }"));
            DateTime date=DateTime.parse(tasks[index].date);
              return Card(
                
              color: DateTime.now().isAfter(date)&&
                tasks[index].status=='pending'?
                Colors.red:
                tasks[index].status=='completed'?
                Colors.green:
                ColorManger.bottom_sheet,
              child: ListTile(
                onLongPress: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return result(

                        tasksModel: tasks[index],
                      );
                  },));
                },
                //   onTap: () {
                //     if(tasks[index].status=='completed'){
                //       tasks[index].status='pending';
                //     }else{
                //       tasks[index].status='completed';
                //     }
                //     SqfliteHelper.instance.updateStatus(tasks[index].id!, tasks[index].status);
                //     getTask();
                //     setState(() {
                //       // tasks[index].status;
                //
                //     });
                //   // Navigator.of(context).push(MaterialPageRoute(builder: (context) {return result();
                //   //     },
                //   //   ));
                // },
                trailing: tasks[index].status=='pending'?IconButton(onPressed: () async{
                  await SqfliteHelper.instance.deleteData(tasks[index].id!);
                  getTask();

                }, icon: Icon(Icons.delete),
                color: Colors.white,
                ):
                    SizedBox(),
                leading: Checkbox(
                  value: tasks[index].status=='completed' ?true:false,
                  onChanged: (value) {
                    if(tasks[index].status=='completed'){
                    tasks[index].status=='pending';
                  }else{
                    tasks[index].status='completed';
                  }
                  SqfliteHelper.instance.updateStatus(tasks[index].id!, tasks[index].status);
                  getTask();
                  setState(() {
                  });
                  },),
                title: Text(tasks[index].title,style: TextStyle(color: Colors.white),),
                subtitle: Text(DateFormat('EEEE').format(date)+ "" + TimeOfDay.fromDateTime(date).format(context),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        )
            : SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(AssetsManger.center),
                height: 200.h,
                width: 200.w,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "what do you want to do today?",
                style: TextStyle(
                    fontFamily: FontsManger.Font_Family,
                    color: Colors.white,
                    fontSize: 20.sp),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Tap + to add your tasks",
                style: TextStyle(fontSize: 15.sp, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r))),
            context: context,
            backgroundColor: ColorManger.bottom_sheet,
            builder: (_) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery
                          .of(context)
                          .viewInsets
                          .bottom),
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Add Task",
                            style: TextStyle(
                                fontFamily: FontsManger.Font_Family,
                                fontSize: 20.sp,
                                color: ColorManger.backgroundcolor),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                label: Text("Task Name")),
                            controller: Text1,
                          ),
                          TextFormField(
                            controller: Text2,
                            decoration: const InputDecoration(
                                label: Text("Task Description")),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showDatePicker(context: context,
                                        firstDate: DateTime(
                                          DateTime.now().year,
                                          DateTime
                                            .now()
                                            .month,
                                          DateTime
                                              .now()
                                              .day,
                                        ),
                                        lastDate: DateTime(DateTime
                                            .now()
                                            .year,
                                            DateTime
                                                .now()
                                                .month,
                                            DateTime
                                                .now()
                                                .day + 40)).then((value) {
                                      selectDate = value!;
                                    },);
                                    showTimePicker(context: context,
                                        initialTime: TimeOfDay.now(),

                                    ).then((
                                        value) {
                                      selectDate = DateTime(
                                          selectDate.year,
                                          selectDate.month,
                                          selectDate.day,
                                          value!.hour,
                                          value!.minute

                                      );
                                    },);
                                  },
                                  icon: Icon(
                                    Icons.lock_clock,
                                    color: Colors.white,
                                  )),
                              Spacer(),
                              IconButton(
                                  onPressed: () async {
                                    await SqfliteHelper.instance.insertData(
                                        TasksModel(
                                          title: Text1.text,
                                          description: Text2.text,
                                          date: selectDate.toString(),
                                        ));
                                    await getTask();
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                  ),
                ),
              );
            },
          );
        }

        ,

        backgroundColor
            :

        ColorManger.backgroundcolor

        ,

        clipBehavior
            :

        Clip.hardEdge

        ,

      )

      ,

    );
  }
}
