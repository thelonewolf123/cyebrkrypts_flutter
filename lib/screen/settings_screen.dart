import 'package:flutter/material.dart';
import '../widget/alert_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  _logout() {
    print('logout');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            elevation: 8,
            child: ListTile(
              leading: const SizedBox(
                height: 85,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                  radius: 50,
                ),
              ),
              title: Text(
                'CyberKrypts',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800]),
              ),
              subtitle: Text(
                'harish@cyberkrypts.com',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),
          Card(
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    'About',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey[500],
                ),
                ListTile(
                  leading: const Icon(
                    Icons.info,
                    color: Colors.red,
                  ),
                  title: Text(
                    'About CyberKrypts',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  onTap: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => const AlertWidget(
                      title: 'About CyberKrypts',
                      discription:
                          'CyberKrypts is a E-learning platform where you can improve your python programming skills.',
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey[500],
                ),
                ListTile(
                  leading: const Icon(
                    Icons.insert_drive_file,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  onTap: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => const AlertWidget(
                      title: 'Privacy Policy',
                      discription:
                          'We are collecting E-mail, Name and Profile picture only for indintification purpose, it won\'t be used for any marketing or advertaising.',
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey[500],
                ),
                ListTile(
                  leading: const Icon(
                    Icons.help,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Terms of Service',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  onTap: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => const AlertWidget(
                      title: 'Terms of Service',
                      discription:
                          'This application created as an experiment, we are not promising any long term support, use it on your own risk.',
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Card(
              elevation: 4,
              child: ListTile(
                title: const Text(
                  'Logout',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.pink),
                ),
                onTap: _logout,
              ),
            ),
          )
        ],
      ),
    );
  }
}
