import 'package:country_app/models/Models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/provider/theme_provider.dart';
import '../utils/apiHelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  Future<List<Country>?>? countryList;

  @override
  void initState() {
    super.initState();
    countryList = ApiHelper.apiHelper.fetchAllCountry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Countrie Finder",
          style: TextStyle(fontSize: 23, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff553587),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
            icon: (Provider.of<ThemeProvider>(context).thmeModel.isdark)
                ? const Icon(
                    Icons.mode_night,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.light_mode_rounded,
                    color: Colors.white,
                  ),
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: countryList,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "Search Country",
                        suffix: GestureDetector(
                          onTap: () {
                            if (searchController.text.isNotEmpty) {
                              countryList = ApiHelper.apiHelper
                                  .fetchSearchCountry(
                                      countryName: searchController.text);
                              setState(() {});
                            } else {
                              countryList =
                                  ApiHelper.apiHelper.fetchAllCountry();
                              setState(() {});
                            }
                          },
                          child: const Icon(Icons.search),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: data!.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Card(
                              child: ListTile(
                                leading: Text(
                                  "${i + 1}",
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      'DetailsPage',
                                      arguments: data[i],
                                    );
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                  ),
                                ),
                                title: Text(data![i]!.countries.toString()),
                              ),
                            ),
                          );
                        },
                        shrinkWrap: true,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      backgroundColor: Color(0xffd6baff),
    );
  }
}
