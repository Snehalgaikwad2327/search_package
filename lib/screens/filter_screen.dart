part of searchbar;

class FilterScreen extends StatefulWidget {
  final List<GtsModelType> typeList;
  const FilterScreen(this.typeList, {Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool contentCheck = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Filter'),
      ),
      body: Column(
        children: [
          Text("Categories"),
          Expanded(
            child: ListView.builder(
                itemCount: widget.typeList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: CheckboxListTile(
                      title: Text(widget.typeList[index].name),
                      value: widget.typeList[index].selected,
                      autofocus: false,
                      controlAffinity: ListTileControlAffinity.trailing,
                      onChanged: (bool? value) {
                        setState(() {
                          widget.typeList[index].selected = value!;
                        });
                      },
                    ),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Color.fromARGB(255, 5, 120, 214),
                  child: Text('Cancel'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: FlatButton(
                  color: Color.fromARGB(255, 5, 120, 214),
                  child: Text("Apply"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    BlocProvider.of<FilterBloc>(context).applyFilter();
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
