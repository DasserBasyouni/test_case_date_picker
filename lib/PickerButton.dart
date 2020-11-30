import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum PickerButtonType { date, time, dateTime, uploadImage }

class ProjectPickerButton extends StatefulWidget {
  final String text;
  final ValueChanged<dynamic> onDateTimePicked;
  final PickerButtonType type;

  ProjectPickerButton({@required this.text, @required this.type, this.onDateTimePicked, LocalKey key})
      : super(key: key);

  @override
  _ProjectPickerButtonState createState() => _ProjectPickerButtonState();
}

class _ProjectPickerButtonState extends State<ProjectPickerButton> {
  String pickedDateTimeStr;

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    switch (widget.type) {
      case PickerButtonType.dateTime:
        iconData = Icons.date_range;
        break;
      case PickerButtonType.uploadImage:
        iconData = Icons.upload_rounded;
        break;
      case PickerButtonType.date:
        iconData = Icons.calendar_today;
        break;
      case PickerButtonType.time:
        iconData = Icons.timer_rounded;
        break;
    }

    return FlatButton(
      padding: EdgeInsets.only(top: 26, bottom: 26),
      hoverColor: Colors.red.withOpacity(.3),
      onPressed: widget.type == PickerButtonType.uploadImage
          ? null
          : widget.type == PickerButtonType.date
              ? getDateOnPress()
              : widget.type == PickerButtonType.time
                  ? getTimeOnPress()
                  : widget.type == PickerButtonType.dateTime
                      ? getDateTimeOnPress()
                      : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      color: Colors.white,
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: Text(
                pickedDateTimeStr == null ? widget.text : pickedDateTimeStr,
                style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ).tr(),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            iconData,
            color: Colors.blue,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  getDateOnPress() {
    return () async {
      DateTime pickedDate = await pickDate();

      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          //pickedDateTimeStr = '${DateFormat.yMd().format(pickedDate)}';
        });
        widget.onDateTimePicked.call(pickedDate);
      }
    };
  }

  getTimeOnPress() {
    return () async {
      TimeOfDay pickedTime = await pickTime();

      if (pickedTime == null) {
        return;
      } else {
        setState(() {
          pickedDateTimeStr = '${pickedTime.format(context)}';
        });
        widget.onDateTimePicked.call(pickedTime);
      }
    };
  }

  getDateTimeOnPress() {
    return () async {
      DateTime pickedDate = await pickDate();

      if (pickedDate == null) {
        //BotToast.showSimpleNotification(title: tr('processIsCanceled'));
        return;
      } else {
        TimeOfDay pickedTime = await pickTime();

        if (pickedTime == null) {
          //BotToast.showSimpleNotification(title: tr('processIsCanceled'));
          return;
        } else {
          DateTime pickedDateTime =
              DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);

          setState(() {
            //pickedDateTimeStr = '${DateFormat.yMd().format(pickedDate)} - ${pickedTime.format(context)}';
          });

          widget.onDateTimePicked.call(pickedDateTime);
        }
      }
    };
  }

  Future<DateTime> pickDate() async {
    return await showDatePicker(
        context: context,
        locale: Locale('ar'),
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 30));
  }

  Future<TimeOfDay> pickTime() async {
    return await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }
}
