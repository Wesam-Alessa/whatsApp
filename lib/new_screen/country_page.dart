import 'package:flutter/material.dart';
import 'package:whats_up/models/country_model.dart';

import '../utils/dimensions.dart';

class CountryPage extends StatefulWidget {
  final Function setCountryData;
  const CountryPage({Key? key, required this.setCountryData}) : super(key: key);

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List<CountryModel> countries = [
    CountryModel(name: "Jordan", code: "+962", flag: "🇯🇴"),
    CountryModel(name: "KSA", code: "+966", flag: "🇸🇦"),
    CountryModel(name: "Egypt", code: "+20", flag: "🇪🇬"),
    CountryModel(name: "United States", code: "+1", flag: "🇺🇸"),
    CountryModel(name: "South Africa", code: "+27", flag: "🇿🇦"),
    CountryModel(name: "Afghanistan", code: "+93", flag: "🇦🇫"),
    CountryModel(name: "United Kingdom", code: "+44", flag: "🇬🇧"),
    CountryModel(name: "Italy", code: "+39", flag: "🇮🇹"),
    CountryModel(name: "India", code: "+91", flag: "🇮🇳"),
    CountryModel(name: "Pakistan", code: "+92", flag: "🇵🇰"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.teal,
          ),
        ),
        title: Text(
          "Choose a country",
          style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.font18,
              wordSpacing: 1),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.teal,
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) => card(countries[index]),
      ),
    );
  }

  Widget card(CountryModel model) {
    return InkWell(
      onTap: () {
        widget.setCountryData(model);
      },
      child: Card(
        margin: const EdgeInsets.all(0.15),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            children: [
              Text(model.flag),
              const SizedBox(width: 15),
              Text(model.name),
              Expanded(
                child: SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(model.code),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
