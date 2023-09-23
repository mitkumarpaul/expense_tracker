import 'package:expense_tracker/controllers/dbhelper.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:expense_tracker/static.dart' as Static;

import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  int? amt;
  String note = "Any Expense";
  String type = "Income";
  DateTime dt = DateTime.now();
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dt,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dt) {
      setState(() {
        dt = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe2e7ef),
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            "Add Transaction",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Static.PrimaryColor,
                  borderRadius: BorderRadius.circular(
                    16.0,
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: const Icon(
                  Icons.attach_money,
                  size: 16.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "0",
                    border: InputBorder.none,
                  ),
                  onChanged: (val) {
                    try {
                      amt = int.parse(val);
                    } catch (e) {
                      // show Error
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          duration: const Duration(
                            seconds: 2,
                          ),
                          content: Row(
                            children: const [
                              Icon(
                                Icons.info_outline,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                "Enter only Numbers as Amount",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Static.PrimaryColor,
                  borderRadius: BorderRadius.circular(
                    16.0,
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: const Icon(
                  Icons.description,
                  size: 16.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Note on Transaction",
                    border: InputBorder.none,
                  ),
                  onChanged: ((value) {
                    note = value;
                  }),
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Static.PrimaryColor,
                  borderRadius: BorderRadius.circular(
                    16.0,
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: const Icon(
                  Icons.description,
                  size: 16.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 12.0,
              ),
              ChoiceChip(
                label: Text(
                  "Expense",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: type == "Expense" ? Colors.white : Colors.black,
                  ),
                ),
                selected: type == "Expense" ? true : false,
                selectedColor: Static.PrimaryColor,
                onSelected: (value) {
                  if (value == true) {
                    setState(() {
                      type = "Expense";
                    });
                  }
                },
              ),
              const SizedBox(
                width: 12.0,
              ),
              ChoiceChip(
                label: Text(
                  "Income",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: type == "Income" ? Colors.white : Colors.black,
                  ),
                ),
                selected: type == "Income" ? true : false,
                selectedColor: Static.PrimaryColor,
                onSelected: (value) {
                  if (value == true) {
                    setState(() {
                      type = "Income";
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 50.0,
            child: TextButton(
              onPressed: () {
                _selectDate(context);
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Static.PrimaryColor,
                      borderRadius: BorderRadius.circular(
                        16.0,
                      ),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: const Icon(
                      Icons.date_range,
                      size: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    "${dt.day} ${months[dt.month - 1]}",
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 50.0,
            child: ElevatedButton(
              onPressed: () async {
                if (amt != null && note.isNotEmpty) {
                  DBHelper dbHelper = DBHelper();
                  await dbHelper.addData(amt!, dt, note, type);
                  Navigator.of(context).pop();
                } else {
                  print("error values not found");
                }
              },
              child: const Text(
                "Add",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
