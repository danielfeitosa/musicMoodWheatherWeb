import 'dart:html';

import 'package:flutter/material.dart';
import 'package:moodwheatherweb/custom_icon_button.dart';
import 'package:moodwheatherweb/custom_text_field.dart';
import 'package:moodwheatherweb/model/tracker_wheather_model.dart';
import 'package:moodwheatherweb/repository/track_wheather_repository.dart';

import '../field_title.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TrackerWheatherRepository repository = TrackerWheatherRepository();

  List<Tracks> listaTracks = [];
  TrackerWheather trackerWheather;
  var controller = TextEditingController();
  String cidade;

  String error = "";

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MoodWheather"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FieldTitle(
                title: 'Informe a Cidade ',
                subtitle: '',
              ),
              CustomTextField(
                controller: controller,
                onChanged: (value) {
                  cidade = value;
                },
                suffix: CustomIconButton(
                  radius: 16,
                  iconData: Icons.search,
                  onTap: () async {
                    try {
                      trackerWheather = await repository.listByCity(cidade);
                    } catch (e) {
                      setState(() {
                        error = e.toString();
                      });
                    }

                    setState(() {});
                  },
                ),
              ),
              Text(error),
              SizedBox(
                height: 20,
              ),
              trackerWheather != null
                  ? Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Text(
                                    "Cidade",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  trailing: Text(
                                    '${trackerWheather.city}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Text(
                                    "Temperatura",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  trailing: Text(
                                    '${trackerWheather.temperature} ºC',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Text(
                                    "Gênero escolhido",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  trailing: Text(
                                    '${trackerWheather.genre} ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (_, index) => ListTile(
                                      title: Text(
                                        trackerWheather.tracks[index].name,
                                      ),
                                      subtitle: Text(trackerWheather
                                          .tracks[index]
                                          .listArtist()),
                                    ),
                                separatorBuilder: (_, __) {
                                  return Divider();
                                },
                                itemCount: trackerWheather != null &&
                                        trackerWheather.tracks != null
                                    ? trackerWheather.tracks.length
                                    : 0),
                          ),
                        )
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
