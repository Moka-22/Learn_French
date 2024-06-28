import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:learnfrenchwithmsuibrahim/sections_screens/pdf_screen.dart';
import 'package:learnfrenchwithmsuibrahim/themes/colors.dart';
import 'package:provider/provider.dart';
import '../models/favorites_model.dart';
import '../provider/favorites_provider.dart';
import '../themes/icons.dart';
import '../widgets/info_widget/section_name_widget.dart';
import '../widgets/text_widgets/primary_text_widget.dart';

class SecondGradeScreen extends StatefulWidget {
  const SecondGradeScreen({super.key});

  @override
  State<SecondGradeScreen> createState() => _SecondGradeScreenState();
}

class _SecondGradeScreenState extends State<SecondGradeScreen> {
  int _selectedSegment = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Section Name
            SectionNameWidget(
              title: '2 Secondary',
            ),
            const SizedBox(height: 20),
            // List of Material
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomSlidingSegmentedControl<int>(
                  initialValue: _selectedSegment,
                  children: {
                    1: TextWidget(
                      text: 'Lessons',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    2: TextWidget(
                      text: 'Videos',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    3: TextWidget(
                      text: 'Questions',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  },
                  decoration: BoxDecoration(
                    color: sColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  thumbDecoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 6.0,
                        spreadRadius: 1.0,
                        offset: Offset(
                          0.0,
                          3.0,
                        ),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInToLinear,
                  onValueChanged: (value) {
                    setState(() {
                      _selectedSegment = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Content
            Expanded(
              child: _buildSegmentContent(),
            ),
          ],
        ),
      ),
    );
  }

// Slide
  Widget _buildSegmentContent() {
    switch (_selectedSegment) {
      case 1:
        return _buildLessonsContent();
      case 2:
        return _buildVideosContent();
      case 3:
      default:
        return _buildQuestionsContent();
    }
  }

  // Lessons Section
  Widget _buildLessonsContent() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: 'First Term'),
              Tab(text: 'Second Term'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildLessonList(),
                _buildLessonSecondTermList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonList() {
    final storageRef = FirebaseStorage.instance.ref('First Term/2 Secondary/');

    return FutureBuilder(
      future: storageRef.listAll(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<String> lessons = [];

          snapshot.data!.items.forEach((file) {
            lessons.add(file.name);
          });

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                return Card(
                  color: backGroundColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () async {
                            final fileRef = storageRef.child(lessons[index]);
                            final url = await fileRef.getDownloadURL();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PdfScreen(
                                  url: url,
                                  pdfName: lessons[index],
                                ),
                              ),
                            );
                          },
                          child: TextWidget(
                            text: lessons[index],
                            color: Colors.black,
                          ),
                        ),
                        Column(
                          children: [
                            Consumer<FavoritesProvider>(
                              builder: (context, provider, child) {
                                bool isFavorite = provider.favorites.any(
                                    (favorite) =>
                                        favorite.id == lessons[index]);

                                return IconButton(
                                  onPressed: () {
                                    if (isFavorite) {
                                      provider.removeFavorite(Favorite(
                                          id: lessons[index],
                                          name: lessons[index],
                                          url: storageRef
                                              .child(lessons[index])
                                              .fullPath));
                                    } else {
                                      provider.addFavorite(Favorite(
                                          id: lessons[index],
                                          name: lessons[index],
                                          url: storageRef
                                              .child(lessons[index])
                                              .fullPath));
                                    }
                                  },
                                  icon: isFavorite
                                      ? favoriteIcon
                                      : favoriteIconFilled,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildLessonSecondTermList() {
    final storageRef = FirebaseStorage.instance.ref('Second Term/2 Secondary/');

    return FutureBuilder(
      future: storageRef.listAll(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<String> lessons = [];

          snapshot.data!.items.forEach((file) {
            lessons.add(file.name);
          });

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                return Card(
                  color: backGroundColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () async {
                            final fileRef = storageRef.child(lessons[index]);
                            final url = await fileRef.getDownloadURL();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PdfScreen(
                                  url: url,
                                  pdfName: lessons[index],
                                ),
                              ),
                            );
                          },
                          child: TextWidget(
                            text: lessons[index],
                            color: Colors.black,
                          ),
                        ),
                        Column(
                          children: [
                            Consumer<FavoritesProvider>(
                              builder: (context, provider, child) {
                                bool isFavorite = provider.favorites.any(
                                    (favorite) =>
                                        favorite.id == lessons[index]);

                                return IconButton(
                                  onPressed: () {
                                    if (isFavorite) {
                                      provider.removeFavorite(Favorite(
                                          id: lessons[index],
                                          name: lessons[index],
                                          url: storageRef
                                              .child(lessons[index])
                                              .fullPath));
                                    } else {
                                      provider.addFavorite(Favorite(
                                          id: lessons[index],
                                          name: lessons[index],
                                          url: storageRef
                                              .child(lessons[index])
                                              .fullPath));
                                    }
                                  },
                                  icon: isFavorite
                                      ? favoriteIcon
                                      : favoriteIconFilled,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  // Videos Section
  Widget _buildVideosContent() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: 'First Term'),
              Tab(text: 'Second Term'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildVideosList(['Soon']),
                _buildVideosList(['Soon']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideosList(List<String> videos) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return Card(
            color: backGroundColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: TextWidget(
                      text: videos[index],
                      color: Colors.black,
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: favoriteIcon,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Questions Section
  Widget _buildQuestionsContent() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: 'First Term'),
              Tab(text: 'Second Term'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildQuestionsList(),
                _buildQuestionsSecondTermList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionsList() {
    final storageRef =
        FirebaseStorage.instance.ref('First Term/2 Secondary/Questions/');

    return FutureBuilder(
      future: storageRef.listAll(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<String> questions = [];

          snapshot.data!.items.forEach((file) {
            questions.add(file.name);
          });

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return Card(
                  color: backGroundColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () async {
                            final fileRef = storageRef.child(questions[index]);
                            final url = await fileRef.getDownloadURL();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PdfScreen(
                                  url: url,
                                  pdfName: questions[index],
                                ),
                              ),
                            );
                          },
                          child: TextWidget(
                            text: questions[index],
                            color: Colors.black,
                          ),
                        ),
                        Column(
                          children: [
                            Consumer<FavoritesProvider>(
                              builder: (context, provider, child) {
                                bool isFavorite = provider.favorites.any(
                                    (favorite) =>
                                        favorite.id == questions[index]);

                                return IconButton(
                                  onPressed: () {
                                    if (isFavorite) {
                                      provider.removeFavorite(Favorite(
                                          id: questions[index],
                                          name: questions[index],
                                          url: storageRef
                                              .child(questions[index])
                                              .fullPath));
                                    } else {
                                      provider.addFavorite(Favorite(
                                          id: questions[index],
                                          name: questions[index],
                                          url: storageRef
                                              .child(questions[index])
                                              .fullPath));
                                    }
                                  },
                                  icon: isFavorite
                                      ? favoriteIcon
                                      : favoriteIconFilled,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildQuestionsSecondTermList() {
    final storageRef =
        FirebaseStorage.instance.ref('Second Term/2 Secondary/Questions/');

    return FutureBuilder(
      future: storageRef.listAll(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<String> questions = [];

          snapshot.data!.items.forEach((file) {
            questions.add(file.name);
          });

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return Card(
                  color: backGroundColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () async {
                            final fileRef = storageRef.child(questions[index]);
                            final url = await fileRef.getDownloadURL();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PdfScreen(
                                  url: url,
                                  pdfName: questions[index],
                                ),
                              ),
                            );
                          },
                          child: TextWidget(
                            text: questions[index],
                            color: Colors.black,
                          ),
                        ),
                        Column(
                          children: [
                            Consumer<FavoritesProvider>(
                              builder: (context, provider, child) {
                                bool isFavorite = provider.favorites.any(
                                    (favorite) =>
                                        favorite.id == questions[index]);

                                return IconButton(
                                  onPressed: () {
                                    if (isFavorite) {
                                      provider.removeFavorite(Favorite(
                                          id: questions[index],
                                          name: questions[index],
                                          url: storageRef
                                              .child(questions[index])
                                              .fullPath));
                                    } else {
                                      provider.addFavorite(Favorite(
                                          id: questions[index],
                                          name: questions[index],
                                          url: storageRef
                                              .child(questions[index])
                                              .fullPath));
                                    }
                                  },
                                  icon: isFavorite
                                      ? favoriteIcon
                                      : favoriteIconFilled,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
