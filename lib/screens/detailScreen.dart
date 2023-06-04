import 'package:flutter/material.dart';
import 'package:weptoon/services/ApiService.dart';

import '../models/webtoonDetail.dart';
import '../models/webtoonEpisode.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    Key? key,
    required this.title,
    required this.thumb,
    required this.id,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetail> webtoon;
  late Future<List<WebtoonEpisode>> episodes;

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getTodayById(widget.id);
    episodes = ApiService.getLatestEpisodeById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
                    child: Container(
                      width: 250,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15,
                              offset: const Offset(10, 10),
                              color: Colors.black.withOpacity(0.5),
                            )
                          ]),
                      child: Image.network(
                        widget.thumb,
                        headers: const {
                          "User-Agent":
                              "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: webtoon,
                builder: (context, future) {
                  if (future.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          future.data!.about,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${future.data!.genre} / ${future.data!.age}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    );
                  }
                  return const Text('Loading..');
                },
              ),
              SizedBox(
                height: 50,
              ),
              FutureBuilder(
                future: episodes,
                builder: (context, future) {
                  if (future.hasData) {
                    return Column(
                      children: [
                        for (var episode in future.data!)
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.green.shade300, width: 2),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  offset: const Offset(5, 5),
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    episode.title,
                                    style: TextStyle(
                                        color: Colors.green.shade400,
                                        fontSize: 14),
                                  ),
                                  Icon(
                                    Icons.chevron_right_rounded,
                                    color: Colors.green.shade300,
                                  ),
                                ],
                              ),
                            ),
                          )
                      ],
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
