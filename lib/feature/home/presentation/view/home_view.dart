
 
//home_page.dart 
 
import 'package:flutter/material.dart'; 
 
class HomePage extends StatelessWidget { 
  const HomePage({super.key}); 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      body: SafeArea( 
        child: Column( 
          children: [ 
            const Padding( 
              padding: EdgeInsets.all(16.0), 
              child: TextField( 
                decoration: InputDecoration( 
                  hintText: 'Search Maps', 
                  prefixIcon: Icon(Icons.search), 
                  border: OutlineInputBorder( 
                    borderRadius: BorderRadius.all(Radius.circular(12)), 
                  ), 
                ), 
              ), 
            ), 
            Expanded( 
              child: Container( 
                color: Colors.grey[200], 
                child: const Center( 
                  child: Text('Map will appear here soon...'), 
                ), 
              ), 
            ), 
          ], 
        ), 
      ), 
    ); 
  } 
} 
 
 
 
 