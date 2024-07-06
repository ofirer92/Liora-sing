import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'gallery_widget.dart';
import 'calendar_widget.dart';
import 'contact_form_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            _buildContactButtons(),
            GalleryWidget(),
            CalendarWidget(),
            ContactFormWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.blue,
      child: Column(
        children: [
          Image.network(
            'assets/images/1.jpeg',
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          Text(
            'לשיר עם ליאורה',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            'טיולים, סיפורים, שירים',
            style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildContactButtons() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 10,
        runSpacing: 10,
        children: [
          ElevatedButton(
            onPressed: () => _launchUrl('https://wa.me/0524508654'),
            child: Text('צור קשר בוואטסאפ'),
          ),
          ElevatedButton(
            onPressed: () => _launchUrl('tel:+0524508654'),
            child: Text('התקשר אלי'),
          ),
          ElevatedButton(
            onPressed: () => _launchUrl('mailto:pinsky5@gmail.com'),
            child: Text('שלח אימייל'),
          ),
        ],
      ),
    );
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}