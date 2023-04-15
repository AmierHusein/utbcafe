import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:utb_cafe/screen/cart_screen.dart';
import '../screen/welcome_screen.dart';

class CustomizedDrawerCusto extends StatefulWidget {
  const CustomizedDrawerCusto({super.key});

  @override
  State<CustomizedDrawerCusto> createState() => _CustomizedDrawerCustoState();

}

class _CustomizedDrawerCustoState extends State<CustomizedDrawerCusto> {
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
          leading: const Icon(Icons.add_shopping_cart_outlined),
          title: const Text('Cart'),
          onTap: () {
            Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => CartScreen(),
                            )
            );
          },
        ),
        // ListTile(
        //   leading: const Icon(Icons.shop),
        //   title: const Text('Order'),
        //   onTap: () {
        //     Navigator.pushNamed(context, '/dash');
        //   },
        // ),
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