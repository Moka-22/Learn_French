import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../themes/colors.dart';

class ContactUsWidget extends StatelessWidget {
  const ContactUsWidget({
    super.key,
  });

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
            height: 100,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'In case of any technical issue Please Send On WhatsApp ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.green,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () async{
                        final Uri _whatsappUri = Uri.parse('https://wa.me/+2001015101531',);
                        await launchUrl(_whatsappUri);
                      },
                      child: Text(
                        '01015101531',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: sColor,
                        ),
                      ),
                    ),
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
