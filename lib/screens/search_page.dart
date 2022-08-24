// ignore_for_file: prefer_const_constructors
part of searchbar;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController enterText = TextEditingController();
  String searchText = '';

  List<GtsModelPage> _allEntries = [];

  List<GtsModelType> typeList = [];
  // List<GtsModelType> sortList = typeList.sort();
  List<String> typeListString = [];

  @override
  initState() {
    readJsonData().then((value) {
      for (var model in value) {
        for (var type in model.type) {
          if (!typeListString.contains(type)) {
            typeListString.add(type);

            typeList.add(GtsModelType(type));

            // typeList.sort();
          }
        }
      }
      // typeList
      //     .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      //debugPrint('typeList: $typeList');
      typeList
          .sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));

      setState(() {
        _allEntries = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterBloc(),
      child: BlocBuilder<FilterBloc, FilterState>(
        builder: (context, state) {
          // var filteredItems = _allEntries.where((element) {
          //   return element.text.toLowerCase().contains(searchText);
          // }).toList();
          debugPrint('done');
          List chekBoxList = [];

          for (var element in typeList) {
            if (element.selected == true) {
              chekBoxList.add(element.name);
              // print(element.name);
            }
          }

          var filteredItems = _allEntries.where((element) {
            bool check = true;

            if (chekBoxList.isNotEmpty) {
              check =
                  element.type.toSet().intersection(chekBoxList.toSet()).isEmpty
                      ? false
                      : true;
            }

            return element.text.toLowerCase().contains(searchText) && check;
          }).toList();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 219, 217, 217),
              // ignore: prefer_const_constructors
              title: Text(
                "Search",
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 2, 77, 138)),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return FilterScreen(typeList);
                          });
                    },
                    icon: const Icon(Icons.filter_list_rounded))
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 18.0, left: 10.0, right: 2.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(1),
                            child: TextField(
                              controller: enterText,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      enterText.text = '';
                                      searchText = '';
                                    });
                                  },
                                  icon: Icon(Icons.cancel),
                                ),
                                hintText: 'Search',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  searchText = value;
                                  // searchText = '';
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            FocusManager.instance.primaryFocus?.unfocus();
                            // searchText = '';
                          });
                        },
                        child: Text("Cancel"),
                      )
                    ],
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    child: filteredItems.isNotEmpty
                        ? ListView.builder(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            itemCount: filteredItems.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(filteredItems[index].chapterName),
                                subtitle: Text("@guidelines"),
                              );
                            })
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                'No results found',
                                style: TextStyle(fontSize: 24),
                              ),
                              Icon(Icons.search_off_rounded)
                            ],
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<List<GtsModelPage>> readJsonData() async {
    final jsondata = await rootBundle.loadString('assets/gts.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => GtsModelPage.fromJson(e)).toList();
  }
}
