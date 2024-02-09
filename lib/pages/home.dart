import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_api/app/configs/AppSettings.dart';
import 'package:teste_api/widgets/NavBar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
@override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettings>(
      builder: (context, appSettings, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
          ),

          drawer: const NavBar(),
          body: Center(
            child: Text(appSettings.conta['setupModel'].welcome ?? 'sem nada'),
              
          ),

        );

      },
    );
  }
}


// Consumer<SetupModel>(
//       builder: (context, storedValue, child) {
//         return Card(
//           child: Text(storedValue.consta)
//         );



// return Consumer<SetupModel>(
//       builder: (context, storedValue, child) {
//         List<Widget> keyValueWidgets = [];
//         storedValue.consta.forEach((key, value) {
//           keyValueWidgets.add(ListTile(
//             title: Text(key),
//             subtitle: Text(value.toString()),
//           ));
//         });

//         return Card(child: Column(children:keyValueWidgets));
//       },
//     );













// class MyApp extends StatelessWidget {
//  const MyApp({super.key});
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF141DA1)),
//         useMaterial3: true,
//       ),
//       home: const Home(),
//     );
//   }
// }


// class Home extends StatefulWidget {
//   const Home({super.key});
//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: const Text('Teste'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.login),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const Login()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: const Column(children: [
//         Change()
//       ]),
//     );
//   }
// }

// class Change extends StatelessWidget {
//   const Change({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<Chang>(builder: (context, storedValue, child) {
//       return Card(child: Text(storedValue.usu));
//     });
//   }
// }
