import 'package:flutter/material.dart';

Widget DefaultTextFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool ispassword = false,
  @required validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: ispassword,
    onFieldSubmitted: onSubmit,
    onChanged: onChange,
    validator: validate,
    onTap: onTap,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: suffix != null ? Icon(suffix) : null,
      border: OutlineInputBorder(),
    ),
  );
}
Widget WidgetBuildTaskItem (Map model)=>Padding(
  padding: const EdgeInsets.only(left: 15,right: 0,top: 5,bottom: 5),
  child: Row(
    children: [
      CircleAvatar(
        radius: 40,
        child: Text(
          '${model['time']}',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(width: 15,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${model['title']}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          Text('${model['date']}',style: TextStyle(fontSize: 15,color: Colors.grey),)

        ],
      ),
    ],
  ),
);
