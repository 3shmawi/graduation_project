import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectWithUs extends StatelessWidget {
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect with Us'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email Us'),
              subtitle: Text('t3aontym@yourcompany.com'),
              onTap: () => _launchURL('mailto:contact@yourcompany.com'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Call Us'),
              subtitle: Text('+1234567890'),
              onTap: () => _launchURL('tel:+1234567890'),
            ),
            ListTile(
              leading: Icon(Icons.web),
              title: Text('Visit Our Website'),
              subtitle: Text('www.t3aontym.com'),
              onTap: () => _launchURL('https://www.t3aontym.com'),
            ),
            ListTile(
              leading: Icon(Icons.facebook),
              title: Text('Facebook'),
              subtitle: Text('3aontym'),
              onTap: () => _launchURL('https://www.facebook.com/t3aontym'),
            ),
            ListTile(
              leading:  const Icon(
                FontAwesomeIcons.twitter,
                size: 30,
              ),
              title: Text('Twitter'),
              subtitle: Text('@t3aontym'),
              onTap: () => _launchURL('https://www.twitter.com/t3aontym'),
            ),
            ListTile(
              leading: const Icon(
                FontAwesomeIcons.linkedin,
                size: 30,
              ),
              title: Text('LinkedIn'),
              subtitle: Text('Your Company'),
              onTap: () => _launchURL('https://www.linkedin.com/company/t3aontym'),
            ),
          ],
        ),
      ),
    );
  }
}