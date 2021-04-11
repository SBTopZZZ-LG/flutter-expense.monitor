import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransaction;

  NewTransaction(this._addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController titleController = TextEditingController(),
      valueController = TextEditingController();

  DateTime _selectedDate;

  void _onInputSubmit(String value) {
    if (num.parse(valueController.text) < 0) return;

    String title = titleController.text;
    num amount =
        num.parse(valueController.text.length > 0 ? valueController.text : -1);

    if (title.length > 0 && amount != -1 && _selectedDate != null) {
      widget._addNewTransaction(
          titleController.text, num.parse(valueController.text), _selectedDate);

      Navigator.of(context).pop();
    }
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((DateTime selectedDate) {
      setState(() {
        _selectedDate = selectedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: titleController,
                onSubmitted: (String value) => _onInputSubmit(value),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: valueController,
                keyboardType: TextInputType.number,
                onSubmitted: (String value) => _onInputSubmit(value),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Text(_selectedDate == null
                        ? "No Date Selected"
                        : "Picked Date: " +
                            _selectedDate
                                .toString()
                                .split(" ")[0]
                                .split("-")
                                .reversed
                                .join("-")),
                    TextButton(
                        onPressed: _presentDatePicker,
                        child: Text("Choose Date")),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              ElevatedButton(
                  onPressed: () => _onInputSubmit(null),
                  child: Text("Add Transaction"))
            ],
            crossAxisAlignment: CrossAxisAlignment.end,
          ),
        ),
      ),
    );
  }
}
