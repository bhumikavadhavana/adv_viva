import 'package:flutter/material.dart';
import 'package:country_app/models/Models.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    Country data = ModalRoute.of(context)!.settings.arguments as Country;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          data.countries,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffecdcff),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Capital : ",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  ...data.capital
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            "${e}",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                      .toList()
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: Row(
                children: [
                  const Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Language : ",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          color: Colors.grey,
                        )),
                  )),
                  ...data.lang.values.map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Text(
                            e.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Card(
              elevation: 5,
              child: Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text("Populations : ",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                            color: Colors.grey,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Text(
                          "${data.population} ",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
