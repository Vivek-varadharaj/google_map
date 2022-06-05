import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:info_skies_map/controllers/image_controller.dart';
import 'package:info_skies_map/models/image_model.dart';
import 'package:info_skies_map/views/screens/map_screen.dart';
import 'package:shimmer/shimmer.dart';

class CarouseScreen extends StatelessWidget {
  CarouseScreen({Key? key}) : super(key: key);
  final ImageController _imageController = ImageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const MapScreen()));
        },
        child: const Text("Get your location on Map"),
      ),
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const Text("Info Skies")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: FutureBuilder(
              future: _imageController.fetchImages(page: 1, limit: 5),
              builder: (context, AsyncSnapshot<List<ImageModel>?> snapShot) {
                if (snapShot.hasData && snapShot.data != null) {
                  return CarouselSlider.builder(
                      options: CarouselOptions(
                          reverse: true, enlargeCenterPage: true),
                      itemCount: snapShot.data!.length,
                      itemBuilder: ((context, index, limit) =>
                          CachedNetworkImage(
                              placeholder: (context, url) => Shimmer.fromColors(
                                    baseColor: Colors.grey.shade500,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                      color: Colors.white,
                                      height: 300,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                              fit: BoxFit.cover,
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                              imageUrl: snapShot.data![index].largeImageUrl)));
                }

                return const Center(
                  child: Text("Some error occured"),
                );
              }),
        ),
      ),
    );
  }
}
