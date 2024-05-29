import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:krishi_vikas/features/app_services/animal_husbandry/animal_view_details.dart';
import 'package:krishi_vikas/features/app_services/fertilizer/add_fertilizer_record.dart';
import 'package:krishi_vikas/features/app_services/fertilizer/fertilizer_services.dart';
import 'package:krishi_vikas/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Fertilizer extends StatelessWidget {
  const Fertilizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String token = prefs.getString("token")!;
            print(token);

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddFertilizerRecord(),
                ));
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text("Fertilizer"),
        ),
        body: FutureBuilder(
          future: FertilizerServices().getAllFertilizersRecords(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SpinKitCircle(color: primary_green);
            } else {
              List data = snapshot.data;

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
                        title: Text(data[index]["name"]),
                        subtitle: Text(data[index]["brand"]));
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
