import 'package:flutter/material.dart';
import 'package:gallery_app/contoer/images_controler.dart';
import 'package:gallery_app/model/images_model.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import '../../contoer/theme_controler.dart';
import '../../sec/imagedata.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String m = "";
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() {
    Provider.of<ImagesControler>(context, listen: false).Updata(name: "all");
  }

  List derk = [
    {'name': "Home", "icon": Icons.home_filled},
    {'name': "About app", "icon": Icons.album_outlined},
    {'name': "Profile", "icon": Icons.portrait_rounded},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            CircleAvatar(
              maxRadius: 50,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "User: Parth Dhameliya",
              style: GoogleFonts.poppins(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              endIndent: 0,
              height: 0.5,
              color: Colors.black38,
            ),
            ...derk.map(
              (e) => ListTile(
                leading: Icon(e['icon']),
                title: Text(
                  "${e['name']}",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.nightlight_outlined),
              title: Text(
                "dart",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                ),
              ),
              trailing: Switch(value: Provider.of<ThemeControler>(context).t.isDark, onChanged: (Val){
                Provider.of<ThemeControler>(context,listen: false).setDark();
              }),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Gallry Photos",
          style: GoogleFonts.poppins(
            fontSize: 20,
          ),
        ),
        actions: [
          AnimSearchBar(
            width: 340,
            textController: textController,
            onSuffixTap: () {
              textController.clear();
            },
            onSubmitted: (p0) {
              Provider.of<ImagesControler>(context, listen: false)
                  .Updata(name: p0);
            },
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...ImageData.map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          Provider.of<ImagesControler>(context, listen: false)
                              .Updata(name: '${e['name']}');
                        },
                        child: Container(
                          height: 200,
                          width: 150,
                          decoration: BoxDecoration(),
                          child: FutureBuilder(
                            future: Provider.of<ImagesControler>(context,
                                    listen: false)
                                .getApi(name: '${e['name']}'),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                Center(
                                  child: Text("${snapshot.error}"),
                                );
                              } else if (snapshot.hasData) {
                                List<ImageModel>? data = snapshot.data;
                                return Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          NetworkImage(data![0].largeimageURL),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${e['name']}",
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return Center(
                                child: Container(
                                  height: 50,
                                  child: LoadingIndicator(
                                    indicatorType: Indicator.ballSpinFadeLoader,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ).toList(),
              ],
            ),
          ),
          SizedBox(
            height: 2.5,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<ImagesControler>(
                builder: (context, value, child) {
                  return FutureBuilder(
                    future: value.h,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        Center(
                          child: Text("${snapshot.error}"),
                        );
                      } else if (snapshot.hasData) {
                        List<ImageModel>? data = snapshot.data;
                        return GridView.custom(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          gridDelegate: SliverQuiltedGridDelegate(
                            crossAxisCount: 4,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            pattern: [
                              QuiltedGridTile(2, 2),
                              QuiltedGridTile(1, 1),
                              QuiltedGridTile(1, 1),
                              QuiltedGridTile(1, 2),
                            ],
                          ),
                          childrenDelegate: SliverChildBuilderDelegate(
                            childCount: data!.length,
                            (context, index) => ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                "${data[index].largeimageURL}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }
                      return Center(
                        child: Container(
                          height: 50,
                          child: LoadingIndicator(
                            indicatorType: Indicator.ballSpinFadeLoader,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
