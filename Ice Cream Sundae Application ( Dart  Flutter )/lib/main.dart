import 'package:assignment_3/OrderScreen.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'AboutScreen.dart';
import 'IceCream.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _dropDownFlavors = ['Vanilla', 'Chocolate', 'Strawberry'];
  final _dropDownSizes = ['Small', 'Medium', 'Large'];

  var _dropDownFlavorsValue = "Vanilla";
  var _dropDownSizesValue = "Small";

  // SIZE COST
  double _sizeCost = 2.99;
  double _toppingsCost = 0.00;
  double _fudgeCost = 0.00;

  // COST
  double _total = 0.00;

  // FUDGE STARTING SIZE
  int _fudgeSize = 0;

  // HOLDS ALL ORDERS MADE
  late final List<GFCard> _orders = [];

  // ADDS TOPPINGS INTO A COLUMN TO DISPLAY IN ORDERS
  late final List<Column> _orderToppings = [];

  // menu items
  List<String> _menuItems = ['Order History', 'About'];

  // checkboxValues
  Map<String, bool> checkBoxValue = {
    'Peanuts': false,
    'M&Ms': false,
    'Almonds': false,
    'Brownies': false,
    'Strawberries': false,
    'Oreos': false,
    'Gummy Bears': false,
    'Marshmallows': false
  };

  IceCream iceCream = IceCream();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    iceCream.addItem("Small", 2.99);
    iceCream.addItem("Medium", 3.99);
    iceCream.addItem("Large", 4.99);

    iceCream.addItem("Peanuts", 0.15);
    iceCream.addItem("M&Ms", 0.25);
    iceCream.addItem("Almonds", 0.15);
    iceCream.addItem("Brownies", 0.20);
    iceCream.addItem("Strawberries", 0.20);
    iceCream.addItem("Oreos", 0.20);
    iceCream.addItem("Gummy Bears", 0.20);
    iceCream.addItem("Marshmallows", 0.15);

    iceCream.addItem("hot fudge 1 oz", 0.15);
    iceCream.addItem("hot fudge 2 oz", 0.25);
    iceCream.addItem("hot fudge 3 oz", 0.30);

    updateUI();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Ice Cream Sundae"),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (choice) {
                choice == _menuItems[0]
                    ? goToOrdersScreen()
                    : gotoAboutScreen();
              },
              itemBuilder: (BuildContext context) {
                return _menuItems.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            Row(
              // _______ICON & TITLE_______

              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: Image.asset('images/ice.png')),
                const Text(
                  "Sundae Maker",
                  style: TextStyle(color: Colors.blue, fontSize: 40),
                ),
              ],
            ),
            Text(
                // _______COST_______
                "\$${_total.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 30,
                )),
            Column(
              // _______DROPDOWN_______

              children: [
                Row(
                  // _______FLAVORS_______
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    const Text("Flavor: ",
                        style:
                            TextStyle(color: Colors.pinkAccent, fontSize: 20)),
                    DropdownButton(
                      value: _dropDownFlavorsValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: _dropDownFlavors.map((String items) {
                        return DropdownMenuItem(
                            value: items, child: Text(items));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _dropDownFlavorsValue = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  // _______SIZES_______

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    const Text(
                      "Size: ",
                      style: TextStyle(
                          color: Colors.green,
                          // backgroundColor: Colors.lightBlueAccent,
                          fontSize: 20),
                    ),
                    DropdownButton(
                      value: _dropDownSizesValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: _dropDownSizes.map((String items) {
                        return DropdownMenuItem(
                            value: items, child: Text(items));
                      }).toList(),
                      onChanged: (String? newValue) {
                        _dropDownSizesValue = newValue!;
                        _sizeCost = iceCream.getPrice(newValue);
                        updateUI();
                      },
                    ),
                  ],
                ),
              ],
            ),
            Row(
              // _______CHECKBOXES_______

              children: [
                Expanded(
                  child: Column(
                    // _______CHECKBOX COLUMN 1_______

                    children: [
                      createCheckBox(0),
                      createCheckBox(1),
                      createCheckBox(2),
                      createCheckBox(3),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    // _______CHECKBOX COLUMN 2_______

                    children: [
                      createCheckBox(4),
                      createCheckBox(5),
                      createCheckBox(6),
                      createCheckBox(7),
                    ],
                  ),
                )
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                decoration: const BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: const Text(
                  'HotFudge',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ), // FUDGE

              Expanded(
                  child: Slider(
                // _______FUDGE SLIDER_______
                value: _fudgeSize.toDouble(),
                min: 0,
                max: 3,
                activeColor: Colors.pink,
                onChanged: (double value) {
                  _fudgeSize = value.round();

                  bool foundItem =
                      iceCream.findItem("Hot Fudge $_fudgeSize oz");
                  double itemPrice =
                      iceCream.getPrice("Hot Fudge $_fudgeSize oz");

                  _fudgeCost = foundItem ? itemPrice : 0.00;

                  updateUI();
                },




                divisions: 3,
                label: "$_fudgeSize oz",
              )),

              Container(
                padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                decoration: const BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Text(
                  '$_fudgeSize oz',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              )
            ]),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                // _______THE WORKS | ORDER | RESET_______
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      max();
                    },
                    child: const Text('The Works!'),
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        textStyle: const TextStyle(
                          fontSize: 20,
                        )),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      reset();
                    },
                    child: const Text('Reset'),
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        textStyle: const TextStyle(
                          fontSize: 20,
                        )),
                  ),
                  ElevatedButton(
                    onPressed: () {

                      ScaffoldMessenger.of(context).showSnackBar(

                          const SnackBar(
                              content: Text("Thank You For Your Order!")

                          )
                      );
                      createOrder();


                    },
                    child: const Text('Order'),
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        textStyle: const TextStyle(
                          fontSize: 20,
                        )),
                  ),
                ],
              ),
            ),
          ],
        )));
  }

  bool? hasTopping() {
    if (_fudgeSize > 0) {
      return true;
    }
    for (int x = 0; x < checkBoxValue.length; x += 1) {
      if (checkBoxValue[getCheckBoxKey(x)] == true) {
        return true;
      }
    }

    return false;
  }

  // CHECKBOX FUNCTIONS
  bool? getCheckBoxValue(int x) {
    String key = getCheckBoxKey(x);
    return checkBoxValue[key];
  }

  String getCheckBoxKey(int x) {
    return checkBoxValue.keys.elementAt(x);
  }

  void updateUI() {
    setState(() {
      _total = (_sizeCost + _toppingsCost + _fudgeCost);
    });
  }

  void reset() {
    _dropDownSizesValue = "Small";

    for (int x = 0; x < checkBoxValue.length; x += 1) {
      if (checkBoxValue[getCheckBoxKey(x)] == true) {
        checkBoxValue[getCheckBoxKey(x)] = false;
      }
    }

    _fudgeSize = 0;

    _sizeCost = iceCream.getPrice(_dropDownSizesValue);
    _fudgeCost = iceCream.getPrice("Hot Fudge $_fudgeSize oz");
    _toppingsCost = 0.00;

    updateUI();
  }

  void max() {
    _dropDownSizesValue = "Large";

    _toppingsCost = 0.00;

    for (int x = 0; x < checkBoxValue.length; x += 1) {
      if (checkBoxValue[getCheckBoxKey(x)] == false) {
        checkBoxValue[getCheckBoxKey(x)] = true;
      }
      _toppingsCost += iceCream.getPrice(getCheckBoxKey(x));
    }

    _fudgeSize = 3;

    _sizeCost = iceCream.getPrice(_dropDownSizesValue);
    _fudgeCost = iceCream.getPrice("Hot Fudge $_fudgeSize oz");
    updateUI();
  }

  void createCard() {
    GFCard card = GFCard(
      elevation: 5.0,
      boxFit: BoxFit.cover,
      titlePosition: GFPosition.start,
      showImage: true,
      title: GFListTile(
        avatar: GFAvatar(backgroundImage: setOrderFlavorImage()),
        titleText: _dropDownFlavorsValue,
        subTitleText:
            '$_dropDownSizesValue | \$${_sizeCost.toStringAsFixed(2)}',
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // margin: const EdgeInsets.only( bottom: 100 ),
        children: [
          if (hasTopping() == true) // if the user selected a topping, show the toppings
            Container(
              // TOPPINGS TEXT
              padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
              decoration: const BoxDecoration(
                  color: Colors.pinkAccent,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: const Text(
                'Toppings',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int x = 0; x < 2; x += 1)
                    if (_orderToppings.length > x) _orderToppings[x]
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int x = 2; x < 4; x += 1)
                    if (_orderToppings.length > x) _orderToppings[x]
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int x = 4; x < 6; x += 1)
                    if (_orderToppings.length > x) _orderToppings[x]
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int x = 6; x < 8; x += 1)
                    if (_orderToppings.length > x) _orderToppings[x]
                ],
              ),
            ],
          ),
          if (_fudgeSize > 0) // show fudge as a topping on orders card, if selected
            Row(
              // FUDGE TEXT
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Text(
                    "Hot Fudge $_fudgeSize oz",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                    ' | \$${iceCream.getPrice("Hot Fudge $_fudgeSize oz").toStringAsFixed(2)}'),
                const SizedBox(height: 50),
              ],
            ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                decoration: const BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: const Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(' | \$${_total.toStringAsFixed(2)}'),
              const SizedBox(height: 50),
            ],
          )
        ],
      ),
    );

    // so it can be shown in order history
    _orders.add(card);
  }

  AssetImage setOrderFlavorImage() {
    if (_dropDownFlavorsValue == 'Vanilla') {
      return const AssetImage('images/vanilla.png');
    } else if (_dropDownFlavorsValue == 'Chocolate') {
      return const AssetImage('images/chocolate.png');
    } else {
      return const AssetImage('images/strawberry.png');
    }
  }

  void createOrder() {
    for (int x = 0; x < checkBoxValue.length; x += 1) {
      if (checkBoxValue[getCheckBoxKey(x)] == true) { // if checkbox for topping was clicked add it to the toppings list
        _orderToppings.add(Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Text(
                    getCheckBoxKey(x),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                    ' | \$${iceCream.getPrice(getCheckBoxKey(x)).toStringAsFixed(2)}'),
                const SizedBox(height: 50)
              ],
            ),
          ],
        ));
      }
    }

    createCard();
    _orderToppings.clear(); // removes previous toppings added
    reset();
  }

  CheckboxListTile createCheckBox(int x) {
    return CheckboxListTile(
        contentPadding: const EdgeInsets.all(2),
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          getCheckBoxKey(x),
        ),
        value: getCheckBoxValue(x),
        activeColor: Colors.blueAccent,
        shape: const CircleBorder(),
        onChanged: (bool? newValue) {
          if (checkBoxValue[getCheckBoxKey(x)] = newValue!) {
            _toppingsCost += iceCream.getPrice(getCheckBoxKey(x));
          } else {
            _toppingsCost -= iceCream.getPrice(getCheckBoxKey(x));
          }

          updateUI();
        });
  }

  void gotoAboutScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AboutScreen(),
      ),
    );
  }

  void goToOrdersScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderScreen(orders: _orders)),
    );
  }
}
