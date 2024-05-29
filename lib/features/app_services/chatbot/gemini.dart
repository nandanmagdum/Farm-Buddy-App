import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:krishi_vikas/utils/colors.dart';

import 'chat_model.dart';
import 'chat_service.dart';

final apiProvider = Provider<ChatService>((ref) => ChatService());

final chatDataProvider = FutureProvider.autoDispose<List<ChatModel>>((ref) {
  return ref.read(apiProvider).getChats();
});

final loadingProvider = StateProvider((ref) => false);

class GEMINI extends StatefulWidget {
  const GEMINI({super.key});

  @override
  State<GEMINI> createState() => _GEMINIState();
}

class _GEMINIState extends State<GEMINI> {
  TextEditingController prompt = TextEditingController();
  final ScrollController _controller = ScrollController();
  final model = GenerativeModel(
      model: 'gemini-pro', apiKey: "AIzaSyBAMM6kjOsgQ6fqE7Ls2ShXuvLyFoeogOo");
  bool isLoading = false;
  String answer = "null";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text("chatbot",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(
                width: width,
                height: height * .78,
                child: Consumer(
                  builder: (context, ref, child) {
                    final chatData = ref.watch(chatDataProvider);
                    return chatData.when(
                      data: (data) {
                        print("********************");
                        print(data);
                        return ListView.builder(
                          // reverse: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Card(
                                    child: ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: width * 0.8),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.green[100],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        padding: const EdgeInsets.all(10),
                                        child:
                                            Text(data[index].prompt.toString()),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Card(
                                    child: ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxWidth: width * 0.8),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child:
                                            Text(data[index].answer.toString()),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      error: (error, stackTrace) {
                        return Center(
                          child: Text(error.toString()),
                        );
                      },
                      loading: () {
                        return const SpinKitCircle(color: primary_green,);
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: [
                    Consumer(builder: (context, ref, child) {
                      return TextFormField(
                          controller: prompt,
                          onChanged: (String? value) {
                            prompt.text = value.toString();
                          },
                          decoration: InputDecoration(
                            suffixIcon: ref
                                    .watch(loadingProvider.notifier)
                                    .state
                                ? const SpinKitCircle(color: primary_green)
                                : IconButton(
                                    onPressed: () async {
                                      // setState(() => isLoading = true);
                                      ref.read(loadingProvider.notifier).state =
                                          true;

                                      final content = [
                                        Content.text(prompt.text)
                                      ];
                                      final response =
                                          await model.generateContent(content);
                                      debugPrint(response.text);
                                      // call api
                                      if (prompt.text.isNotEmpty) {
                                        await ChatService().addChat(
                                            prompt.text.trim(), response.text!);
                                        ref.refresh(chatDataProvider);
                                      }

                                      ref.read(loadingProvider.notifier).state =
                                          false;

                                      prompt.clear();
                                    },
                                    icon: const Icon(Icons.send)),
                            hintText: "Enter your prompt",
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                          ));
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
