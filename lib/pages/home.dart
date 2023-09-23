import 'dart:ui';

import 'package:expense_tracker/controllers/dbhelper.dart';
import 'package:expense_tracker/pages/addtransaction.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:expense_tracker/static.dart' as Static;

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int total = 0;
  int totalexpense = 0;
  int totalincome = 0;
  DBHelper db = DBHelper();
  List<FlSpot> dataset = [];
  DateTime today = DateTime.now();
  List<FlSpot> getPlotData(Map entireData) {
    dataset = [];
    entireData.forEach((key, value) {
      if (value["type"] == "Expense" &&
          (value["date"] as DateTime).month == today.month) {
        dataset.add(
          FlSpot((value["date"] as DateTime).day.toDouble(),
              (value["amount"] as int).toDouble()),
        );
      }
    });

    return dataset;
  }

  getTotal(Map entireData) {
    total = 0;
    totalexpense = 0;
    totalincome = 0;

    entireData.forEach((key, value) {
      if (value['type'] == "Income") {
        totalincome += (value['amount'] as int);
        total += (value["amount"] as int);
      } else if (value['type'] == "Expense") {
        totalexpense += (value['amount'] as int);
        total += (value["amount"] as int);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe2e7ef),
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => AddTransaction(),
            ),
          )
              .whenComplete(() {
            setState(() {});
          });
        },
        backgroundColor: Static.PrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: const Icon(
          Icons.add,
          size: 32.0,
        ),
      ),
      body: FutureBuilder<Map>(
        future: db.fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No Value"),
              );
            }
            getTotal(snapshot.data!);
            getPlotData(snapshot.data!);
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                32.0,
                              ),
                              color: Colors.white70,
                            ),
                            child: CircleAvatar(
                              maxRadius: 32.0,
                              child: Image.asset(
                                "assets/face.png",
                                width: 64.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Hello Raj",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w700,
                              color: Static.PrimaryMaterialColor[800],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                          color: Colors.white70,
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: const Icon(
                          Icons.settings,
                          size: 32.0,
                          color: Color(0xff3E454C),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: const EdgeInsets.all(
                    12.0,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Static.PrimaryColor,
                          Colors.blueAccent,
                        ],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          24.0,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 8.0,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Total Balance",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "Rs $total",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              cardIncome(
                                totalincome.toString(),
                              ),
                              cardExpense(
                                totalexpense.toString(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Expenses",
                    style: TextStyle(
                      fontSize: 32.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                //
                //
                //
                dataset.length < 2
                    ? Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              8.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 6,
                                spreadRadius: 5,
                                offset: const Offset(0, 4),
                              ),
                            ]),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 40.0,
                        ),
                        margin: const EdgeInsets.all(
                          12.0,
                        ),
                        child: const Text("Not Enough Data to render chart"))
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              8.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 6,
                                spreadRadius: 5,
                                offset: const Offset(0, 4),
                              ),
                            ]),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 40.0,
                        ),
                        margin: const EdgeInsets.all(
                          12.0,
                        ),
                        height: 400.0,
                        child: LineChart(
                          LineChartData(
                            borderData: FlBorderData(
                              show: false,
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: getPlotData(snapshot.data!),
                                isCurved: false,
                                barWidth: 2.5,
                                color: Static.PrimaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                //
                //
                //

                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Recent Transactions",
                    style: TextStyle(
                      fontSize: 32.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: ((context, index) {
                    Map dataatIndex = snapshot.data![index];
                    if (dataatIndex["type"] == "Income") {
                      return IncomeTile(
                        dataatIndex["note"],
                        dataatIndex["amount"],
                      );
                    } else {
                      return ExpenseTile(
                          dataatIndex["note"], dataatIndex["amount"]);
                    }
                    // return ExpenseTile("note", 100);
                  }),
                )
              ],
            );
          } else {
            return const Center(
              child: Text("Error"),
            );
          }
        },
      ),
    );
  }

  Widget cardIncome(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          padding: const EdgeInsets.all(
            6.0,
          ),
          margin: const EdgeInsets.only(
            right: 8.0,
          ),
          child: Icon(
            Icons.arrow_downward,
            size: 28.0,
            color: Colors.green[700],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Income",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white70,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget cardExpense(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          padding: const EdgeInsets.all(
            6.0,
          ),
          margin: const EdgeInsets.only(
            right: 8.0,
          ),
          child: Icon(
            Icons.arrow_upward,
            size: 28.0,
            color: Colors.red[700],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Expense",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white70,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget ExpenseTile(String note, int val) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(
          0xffced4eb,
        ),
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.arrow_circle_up_outlined,
                color: Colors.red[700],
                size: 28.0,
              ),
              const SizedBox(
                width: 4.0,
              ),
              const Text(
                "Expense",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              )
            ],
          ),
          Text(
            "-$val",
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget IncomeTile(String note, int val) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(
          0xffced4eb,
        ),
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.arrow_circle_down_outlined,
                color: Colors.green[700],
                size: 28.0,
              ),
              const SizedBox(
                width: 4.0,
              ),
              const Text(
                "Income",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              )
            ],
          ),
          Text(
            "+$val",
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
