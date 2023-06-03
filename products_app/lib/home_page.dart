// prefer_const_constructors, 

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:products_app/products.dart';
import 'package:products_app/services.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  final String title = "Flutter Laravel CRUD";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Product> _products = [];
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late TextEditingController _nameController;
  late TextEditingController _qtyController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late Product _selectedProduct;
  late bool _isUpdating;
  late String _titleProgress;

  @override
  void initState() {
    super.initState();
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _nameController = TextEditingController();
    _qtyController = TextEditingController();
    _priceController = TextEditingController();
    _descriptionController = TextEditingController();
    fetchData();
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _addProduct(){
    if(_nameController.text.trim().isEmpty || _descriptionController.text.trim().isEmpty || _qtyController.text.trim().isEmpty || _priceController.text.trim().isEmpty) {
      print("Empty fields");
      return;
    }
    _showProgress('Adding Product...');
    Services.addProduct(_nameController.text, _qtyController.text, _priceController.text, _descriptionController.text).then((result){
      if(result) {
        fetchData();
      }
      _clearValues();
    });
  }
  fetchData() {
    _showProgress('Loading Products...');
    Services.getProduct().then((products) {
      setState(() {
        _products = products;
      });
      _showProgress(widget.title);
    });
  }

  _deleteProducts(Product product) {
    _showProgress("Deleting Products...");
    Services.deleteProduct(product.id).then((result) {
      if (result) {
        setState(() {
          _products.remove(product);
        });
        fetchData();
      }
    });
  }

  _updateProducts(Product product) {
    _showProgress('Updating Product...');
    Services.updateProduct(
            product.id,
            _nameController.text,
            _qtyController.text,
            _priceController.text,
            _descriptionController.text)
        .then((result) {
      if (result) {
        fetchData();
        setState(() {
          _isUpdating = false;
        });
        _nameController.text = '';
        _qtyController.text = '';
        _priceController.text = '';
        _descriptionController.text = '';
      }
    });
  }

  _setValues(Product product) {
    _nameController.text = product.name;
    _qtyController.text = product.qty;
    _priceController.text = product.price;
    _descriptionController.text = product.description;

    setState(() {
      _isUpdating = true;
    });
  }

  _clearValues() {
    _nameController.text = '';
    _qtyController.text = '';
    _priceController.text = '';
    _descriptionController.text = '';
  }

  showSnackBar(context, message) {
    _scaffoldKey.currentState!;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
  _databody(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          dataTextStyle: const TextStyle(color: Colors.white),
          headingRowColor:
              MaterialStateColor.resolveWith((states) => Colors.teal),
          dataRowColor: MaterialStateColor.resolveWith(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.selected)
                      ? Colors.white
                      : Colors.black),
          columns: const [
            DataColumn(
                label: Text("ID"),
                numeric: false,
                tooltip: "This is the product id"),
            DataColumn(
                label: Text(
                  "Product Name",
                ),
                numeric: false,
                tooltip: "This is the name"),
            DataColumn(
                label: Text("Quantity"),
                numeric: true,
                tooltip: "These are the amount of products"),
            DataColumn(
                label: Text(
                  "Price",
                ),
                numeric: true,
                tooltip: "This is the price"),
            DataColumn(
                label: Text(
                  "Description",
                ),
                numeric: false,
                tooltip: "This is the description"),
            DataColumn(
                label: Text("DELETE"),
                numeric: false,
                tooltip: "Delete Action"),
          ],
          rows: _products.map((product) {return DataRow(
                  cells: [
                    DataCell(
                      Text(product.id),
                      onTap: () {
                        if (kDebugMode) {
                          print("Tapped" + product.name);
                        }
                        _setValues(product);
                        _selectedProduct = product;
                      },
                    ),
                    DataCell(
                      Text(
                        product.name,
                      ),
                      onTap: () {
                        if (kDebugMode) {
                          print("Tapped " + product.name);
                        }
                        _setValues(product);
                        _selectedProduct = product;
                      },
                    ),
                    DataCell(
                      Text(
                        product.qty,
                      ),
                      onTap: () {
                        if (kDebugMode) {
                          print("Tapped " + product.qty);
                        }
                        _setValues(product);
                        _selectedProduct = product;
                      },
                    ),
                    DataCell(
                      Text(
                        product.price,
                      ),
                      onTap: () {
                        if (kDebugMode) {
                          print("Tapped " + product.price);
                        }
                        _setValues(product);
                        _selectedProduct = product;
                      },
                    ),
                    DataCell(
                      Text(
                        product.description,
                      ),
                      onTap: () {
                        if (kDebugMode) {
                          print("Tapped " + product.description);
                        }
                        _setValues(product);
                        _selectedProduct = product;
                      },
                    ),
                    DataCell(
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          _deleteProducts(product);
                        },
                      ),
                      onTap: () {
                        if (kDebugMode) {
                          print("Deleted" + product.name);
                        }
                      },
                    ),
                  ]);
                  }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(_titleProgress),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              fetchData();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration.collapsed(hintText: "Product Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _qtyController,
                decoration: const InputDecoration.collapsed(hintText: "Quantity"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _priceController,
                decoration: const InputDecoration.collapsed(hintText: "Price"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _descriptionController,
                decoration: const InputDecoration.collapsed(hintText: "Description"),
              ),
            ),
            _isUpdating ? Row(
              children: <Widget>[
                OutlinedButton(onPressed: () {
                  _updateProducts(_selectedProduct);
                }, child: Text('UPDATE'),
                ),
               OutlinedButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    setState(() {
                      _isUpdating = false;
                    });
                    _clearValues();
                  },
                ), 
              ],
            )
            : Container(),
            Expanded(
              child: _databody(),
            )
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: DataTable(
            //     columns: const [
            //       DataColumn(label: Text('id')),
            //       DataColumn(label: Text('name')),
            //       DataColumn(label: Text('qty')),
            //       DataColumn(label: Text('price')),
            //       DataColumn(label: Text('description')),
            //     ], 
            //     rows: data.map((item){
            //       return DataRow(cells: [
            //         DataCell(Text(item['id'].toString())),
            //         DataCell(Text(item['name'])),
            //         DataCell(Text(item['qty'].toString())),
            //         DataCell(Text(item['price'.toString()])),
            //         DataCell(Text(item['description'])),
            //         ]);
            //     }).toList(),
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _addProduct();
      },
      child: const Icon(Icons.add),
      ),
    );
  }
}
