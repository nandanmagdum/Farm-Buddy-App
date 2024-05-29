import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:krishi_vikas/features/app_services/animal_husbandry/animal_view_details.dart';
import 'package:krishi_vikas/features/app_services/soil_analysis/soil_analysis_services.dart';
import 'package:krishi_vikas/utils/colors.dart';

class SoilAnalysis extends StatelessWidget {
  const SoilAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Soil Analysis")),
        body: FutureBuilder(
          future: SoilAnalysisServices().getAllSoilAnalysisRecords(),
          builder: (context, snapshot) {
            List data = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SpinKitCircle(color: primary_green);
            } else {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  if (snapshot.hasData) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewDetails(
                                object: data[index],
                                photo_url: data[index]['photo_url'])));
                      },
                      title: Text(data[index]["organization"]),
                      subtitle: Text(data[index]["name"]),
                    );
                  } else if (snapshot.hasError) {
                    return const Text("Error");
                  } else {
                    return const Text("No Data");
                  }
                },
              );
            }
          },
        ));
  }
}
