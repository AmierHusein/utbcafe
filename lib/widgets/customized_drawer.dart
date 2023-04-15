import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screen/welcome_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super (key: key);
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
        SizedBox(
          height: 65.0,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              'UTB Cafe',
              style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Colors.white),
            ),
          ),
        ),
         ListTile(
          leading: const Icon(Icons.dashboard),
          title: const Text('Dashboard'),
          onTap: () {
            Navigator.pushNamed(context, '/dash');
          },
        ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
                // ignore: use_build_context_synchronously
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const WelcomeScreen();
            }));
            },
          )

        ]
      ),
    );
  }
}