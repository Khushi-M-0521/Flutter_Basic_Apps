import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';

enum ChartType {all, lastMonth, specificDate}

class Chart extends StatefulWidget {
  const Chart(this._allExpenses, {super.key});

  final List<Expense> _allExpenses;

  @override
  State<Chart> createState() {
    return _ChartState();
  }
}

class _ChartState extends State<Chart> {

  ChartType _chartType=ChartType.all;
  List<Expense> _chartExpenses=[];
  DateTime? _specificDate;
  IconButton? _dateIconPiceker;

  @override
  void initState(){
    _chartExpenses=widget._allExpenses;
    _dateIconPiceker=IconButton(onPressed: _datePicker, icon: const Icon(Icons.calendar_month));
    super.initState();
  }

  void _datePicker()async{
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _specificDate==null?now:_specificDate!,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _specificDate = pickedDate;
      _changeChartType(ChartType.specificDate);
    });
  }

  void _changeChartType(ChartType? value){
    if(value==null)
    {
      return;
    }
    setState(() {
      _chartType = value;
      if(_chartType==ChartType.all){
        _chartExpenses=widget._allExpenses;
      }
      else if(_chartType==ChartType.lastMonth) {
        final now=DateTime.now();
        final lastMonthDate=DateTime(now.year,now.month-1,now.day);
        _chartExpenses=[];
        for(final exp in widget._allExpenses){
          if(exp.date.isAfter(lastMonthDate)){
            _chartExpenses.add(exp);
        }
        }
      }
      else if(_chartType==ChartType.specificDate){
        _chartExpenses=[];
        for(final exp in widget._allExpenses){
          if(exp.date.isAfter(_specificDate!)){
            _chartExpenses.add(exp);
        }
        }
      }
    });
  }

  List<ExpenseBucket> get buckets{
    return Category.values.map((category) => ExpenseBucket.forCategory(_chartExpenses,category)).toList();
  }

  double get maxTotalExpense{
    double maxTotalExpense=0;
    for(final bucket in buckets){
      if(bucket.totalExpenses>maxTotalExpense){
        maxTotalExpense=bucket.totalExpenses;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0),
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        DropdownButton(
        value: _chartType ,
        items: [
          DropdownMenuItem(
            value: ChartType.all,
            child: Text('All Expenses',style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.normal),
            ),),
          DropdownMenuItem(
            value: ChartType.lastMonth,
            child: Text('Last 30 Days',style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.normal),
            ),),
          DropdownMenuItem(
            value: ChartType.specificDate,
            child: Row(
              children: [
                Text('Specific Date: ${_specificDate==null? '' : formatter.format(_specificDate!)}',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.normal),
                ),
                _dateIconPiceker!,
              ],
            ),),
        ],
        onChanged: _changeChartType),
        const SizedBox(height: 15,),
        Expanded(child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for(final bucket in buckets)
              Chart_Bar(
                fill: bucket.totalExpenses==0?0:bucket.totalExpenses/maxTotalExpense,
              )
          ],
        ),),
        const SizedBox(height: 10),
        Row(
          children: buckets.map((bucket) => Expanded(
            child: Padding(padding: const EdgeInsets.all(4),
            child: Icon(
              categoryIcons[bucket.category],
              color: Theme.of(context).colorScheme.secondary,
            ),),
          ),).toList(),
        )
      ],),
    );
  }
}
