import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:CalendarApp()
    );
  }
}

class CalendarApp extends StatefulWidget {
  const CalendarApp({super.key});

  @override
  State<CalendarApp> createState() => _CalendarAppState();
}

class _CalendarAppState extends State<CalendarApp> {

  //選択中の日付を管理
  DateTime _selectedDay = DateTime.now();

  //フォーカスされるページを管理する変数
  DateTime _focusedDay = DateTime.now();

  //フォーマットを管理する変数
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:TableCalendar(
        focusedDay: _focusedDay,        //フォーカスする日を指定
        firstDay: DateTime.utc(2026,1,1),  //カレンダーの最初の日を設定
        lastDay: DateTime.utc(2026,12,31), //カレンダーの最後の日を指定
        calendarFormat: _calendarFormat,

        //どの日付が選択されたかを判定する関数
        selectedDayPredicate: (calendarCellDay){
          //２つのDateTimeを比較して一致していた場合、trueを返す
          return isSameDay(_selectedDay, calendarCellDay);
        },

        //日付を選択した時に呼ばれる
        onDaySelected: (tappedDay,focusedDay){
          setState(() {
            //selectedDay:選択した日付の情報が格納されている
            _selectedDay = tappedDay; 
            _focusedDay = focusedDay;
          });
        },

        //フォーマットを切り替えた時に呼ばれる
        onFormatChanged: (format){
          setState(() {
            _calendarFormat = format;
          });
        },

        //ページを切り替えた時に呼ばれる
        onPageChanged: (focusedDay){
          setState(() {
            _focusedDay = focusedDay;
          });
        },
      ),
    );
  }
}