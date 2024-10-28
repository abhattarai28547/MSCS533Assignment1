

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversion',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:  Color.fromRGBO(0, 0, 255,0.8)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Convert'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Initialization of the variables planned to use in any kind of conversion
  String selectedMeasure = 'Weight';
  String selectedUnitFrom = 'Pounds';
  String selectedUnitTo = 'Kilograms';
  String inputValue = '';
  String result = '0';
   
  final myController = TextEditingController();

  @override
  void dispose() {
    // We need to clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  // Creaating maps for ratio to which units its being converted to
  final Map<String,double> distanceUnits = {
    'Miles': 0.621371 ,
    'Kilometers': 1.60934,
  };

  final Map<String,double> weightUnits = {
    'Pounds': 2.20462,
    'Kilograms': 0.453592,
  };

  final Map<String,double> liquidUnits = {
    'Fluid Ounces': 0.033814,
    'Mililiters': 29.5735,
  };



  void converter() {
   
    setState(() {
      // setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values.
      inputValue = myController.text;
      double input= double.tryParse(inputValue) ?? 0.0;
      double conversionFactor;
      double resultValue;


      if (selectedMeasure == 'Distance' && selectedUnitTo != selectedUnitFrom) {
        conversionFactor = distanceUnits[selectedUnitTo]! ;
        resultValue = input * conversionFactor;
        result= '$resultValue $selectedUnitTo';
      } 
      else if (selectedMeasure == 'Weight' && selectedUnitTo != selectedUnitFrom) {
        conversionFactor = weightUnits[selectedUnitTo]! ;
        resultValue = input * conversionFactor;
        result= '$resultValue $selectedUnitTo';
      }
      else if (selectedMeasure == 'Liquid' && selectedUnitTo != selectedUnitFrom) {
        conversionFactor = liquidUnits[selectedUnitTo]! ;
        resultValue = input * conversionFactor;
        result= '$resultValue $selectedUnitTo';
      }
      else if (selectedMeasure == 'Tempertaure' && selectedUnitTo != selectedUnitFrom) {
        if (selectedUnitFrom == 'Fahrenheit' && selectedUnitTo != selectedUnitFrom) {
          resultValue = (input - 32) * 5 / 9; // Convert F to C
        } else {
          resultValue = (input * 9 / 5) + 32; // Convert C to F
        }
        result = '$resultValue  $selectedUnitTo';
        return;
      }
      else {
        result = 'Try Again';
      }

      
    });
    
  }
  

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
 
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: const Color.fromRGBO(233, 120, 50, 0.5),
        title: Text(widget.title),
      ),
      body: Center(
        
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: myController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Value',
                ),
                keyboardType: TextInputType.number,
            ),
            RadioListTile<String>(
              value: 'Distance',
              title: const Text('Distance'), 
              groupValue: selectedMeasure, 
              onChanged: (value){
                setState(() {
                  selectedMeasure = value!;
                  selectedUnitFrom = 'Miles';
                  selectedUnitTo = 'Kilometers';
                });
              }
            ),
            RadioListTile<String>(
              value: 'Weight',
              title: const Text('Weight'),
              groupValue: selectedMeasure,
              onChanged: (value) {
                setState(() {
                  selectedMeasure = value!;
                  selectedUnitFrom = 'Pounds'; 
                  selectedUnitTo = 'Kilograms';
                });
              }
            ),
            RadioListTile<String>(
              value: 'Liquid',
              title: const Text('Liquid'),  
              groupValue: selectedMeasure, 
              onChanged: (value){
                setState(() {
                  selectedMeasure = value!;
                  selectedUnitFrom = 'Fluid Ounces';
                  selectedUnitTo = 'Mililiters';
                });
              }
            ),
            RadioListTile<String>(
              value: 'Temperature',
              title: const Text('Temperature'), 
              groupValue: selectedMeasure, 
              onChanged: (value){
                setState(() {
                  selectedMeasure = value!;
                  selectedUnitFrom = 'Fahrenheit';
                  selectedUnitTo = 'Celsius';
                });
              }
            ),
            
            DropdownButton<String>(
              value: selectedUnitFrom,
              items: getUnits(selectedMeasure),
              onChanged: (String? value) {  
                setState(() {
                  selectedUnitFrom = value!;                
                }); 
              },
            ),
            DropdownButton<String>(
              value: selectedUnitTo,
              items: getUnits(selectedMeasure),
              onChanged: (String? value) {  
                setState(() {
                  selectedUnitTo = value!;                
                }); 
              },
            ),
            TextButton(onPressed: () async {
              converter();
            }, 
              child: const Text('Convert')),
            
            Text('Your result is: $result'),
            
          ],
          
        ),

      ),
    );
  }
  
  List<DropdownMenuItem<String>> getUnits(String measure) {
    if (measure == 'Distance'){
      return const[
        DropdownMenuItem(value: 'Miles', child: Text("Miles")),
        DropdownMenuItem(value: 'Kilometers', child: Text("Kilometers")),
      ];
    }
    else if (measure == 'Weight'){
      return const[
        DropdownMenuItem(value: 'Pounds', child: Text("Pounds")),
        DropdownMenuItem(value: 'Kilograms', child: Text("Kilograms")),
      ];      
    }
    else if (measure == 'Liquid'){
      return const[
        DropdownMenuItem(value: 'Fluid Ounces', child: Text("Fluid Ounces")),
        DropdownMenuItem(value: 'Mililiters', child: Text("Mililiters")),
      ];      
    }
    else {
      return const[
        DropdownMenuItem(value: 'Fahrenheit', child: Text("Fahrenheit")),
        DropdownMenuItem(value: 'Celsius', child: Text("Celsius")),
      ];
    }
  }
}
