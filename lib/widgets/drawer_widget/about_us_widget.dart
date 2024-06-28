import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../themes/colors.dart';
import '../text_widgets/primary_text_widget.dart';

class AboutUsWidget extends StatefulWidget {
  const AboutUsWidget({super.key});

  @override
  State<AboutUsWidget> createState() => _AboutUsWidgetState();
}

class _AboutUsWidgetState extends State<AboutUsWidget> {
  final webSiteUri =
      Uri.parse('https://www.facebook.com/profile.php?id=61560334333457');

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.black12 : backGroundColor,
              border: Border.all(
                color: sColor,
              ),
            ),
            height: 740,
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                // Pic
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage:
                          AssetImage('assets/instructor_image/Instructor.jpg'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextWidget(text: 'Msu : Ibrahim Radwan'),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(text: 'Graduated from : Faculty Of Alsun'),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(text: 'Major : Italian and French Languages'),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                    text:
                        'years of experience in teaching \n French language for all levels'),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(text: 'Let\'s Join Us'),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                    const SizedBox(
                      width: 5,
                    ),
                    Link(
                      uri: webSiteUri,
                      builder: (context, webSiteUri) => GestureDetector(
                        onTap: webSiteUri,
                        child: TextWidget(
                          text: 'Facebook Page',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.phone,
                      color: sColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextWidget(
                      text: '+',
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.green,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final Uri _telUri = Uri(scheme: 'tel', path: '01092004994');
                        final Uri _whatsappUri = Uri.parse('https://wa.me/+2001092004994',);
                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Choose an option'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    if (await canLaunchUrl(_telUri)) {
                                      await launchUrl(_telUri);
                                    } else {
                                      throw 'Could not launch $_telUri';
                                    }
                                  },
                                  child: Text('Call'),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                   await launchUrl(_whatsappUri);
                                  },
                                  child: Text('WhatsApp'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: TextWidget(text: '01092004994'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.phone,
                      color: sColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                        onTap: () async{
                          final Uri _telUri = Uri(scheme: 'tel',path: '01212131904');
                          if(await canLaunchUrl(_telUri)){
                            await launchUrl(_telUri);
                          }else{
                            return null;
                          }
                        },
                        child: TextWidget(text: '01212131904')),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.locationDot,
                      color: sColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextWidget(text: 'ElRowad Center - Quesna - Menofia'),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.locationDot,
                      color: sColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextWidget(text: 'Bdaya Center - Shebeen Elkom - Menofia'),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.locationDot,
                      color: sColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextWidget(text: 'Smart Center - Benha - Qalyubia'),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.locationDot,
                      color: sColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextWidget(text: 'AlTamyoz Center -Benha - Qalyubia'),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.locationDot,
                      color: sColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextWidget(
                        text: 'AlAwaal Center - El Remaly - Quesna - Menofia'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
