import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g3_interactive_task/core/constants/debouncer.dart';
import 'package:g3_interactive_task/core/dependencies/dependencies.dart';
import 'package:g3_interactive_task/core/size_helper/size_helper.dart';
import 'package:g3_interactive_task/features/personnel_form/presentation/pages/personnel_form_screen.dart';
import 'package:g3_interactive_task/features/personnel_list/presentation/bloc/personnel_list_bloc.dart';
import 'package:g3_interactive_task/features/personnel_list/presentation/widgets/personnel_card.dart';
import 'package:g3_interactive_task/shared/common_widgets/custom_text.dart';

class PersonnelListScreen extends StatefulWidget {
  const PersonnelListScreen({super.key});

  @override
  State<PersonnelListScreen> createState() => _PersonnelListScreenState();
}

class _PersonnelListScreenState extends State<PersonnelListScreen> {
  final TextEditingController _searchController = TextEditingController();

  Debouncer debouncer = Debouncer(milliseconds: 700);

  @override
  void initState() {
    sl<PersonnelListBloc>().add(FetchPersonnelListEvent());
    super.initState();
  }

  void _filterPersonnel(String query) {
    setState(() {
      sl<PersonnelListBloc>().filteredPersonnel =
          sl<PersonnelListBloc>().personnelList.where((person) {
        return person.firstName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: Column(
        children: [
          Container(
            height: sl<SizeHelper>().getWidgetHeight(180),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/registration/registration_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: sl<SizeHelper>().getWidgetHeight(35),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: sl<SizeHelper>().getWidgetHeight(30),
                          height: sl<SizeHelper>().getWidgetHeight(30),
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Icon(Icons.grid_view_outlined,
                              size: sl<SizeHelper>().getWidgetWidth(18)),
                        ),
                        Container(
                          width: sl<SizeHelper>().getWidgetHeight(30),
                          height: sl<SizeHelper>().getWidgetHeight(30),
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Icon(Icons.person,
                              size: sl<SizeHelper>().getWidgetWidth(18)),
                        ),
                      ],
                    ),
                    SizedBox(height: sl<SizeHelper>().getWidgetHeight(20)),
                    CustomText(
                      fontSize: sl<SizeHelper>().getTextSize(20),
                      text: 'Personnel Details List',
                      textColor: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(sl<SizeHelper>().getWidgetWidth(16)),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          debouncer.run(() {
                            _filterPersonnel(value);
                          });
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Search...",
                        hintStyle: TextStyle(
                            fontSize: sl<SizeHelper>().getTextSize(13),
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: sl<SizeHelper>().getWidgetWidth(10),
                          horizontal: sl<SizeHelper>().getWidgetWidth(20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: sl<SizeHelper>().getWidgetWidth(12)),
                InkWell(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () {
                    _filterPersonnel(_searchController.text.trim());
                  },
                  child: Container(
                    width: sl<SizeHelper>().getWidgetHeight(42),
                    height: sl<SizeHelper>().getWidgetHeight(42),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 250, 195, 75),
                        shape: BoxShape.circle),
                    child: Center(
                      child: CustomText(
                        fontSize: sl<SizeHelper>().getTextSize(15),
                        text: 'GO',
                        textColor: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<PersonnelListBloc, PersonnelListState>(
              bloc: sl<PersonnelListBloc>(),
              builder: (context, state) {
                return state is FetchPersonnelListLoadingState
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 3,
                        ),
                      )
                    : state is FetchPersonnelListSuccessState
                        ? sl<PersonnelListBloc>().filteredPersonnel.isEmpty
                            ? Center(
                                child: CustomText(
                                  fontSize: sl<SizeHelper>().getTextSize(15),
                                  text: "No items found",
                                  textColor: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        sl<SizeHelper>().getWidgetWidth(16)),
                                itemCount: sl<PersonnelListBloc>()
                                    .filteredPersonnel
                                    .length,
                                itemBuilder: (context, index) {
                                  return PersonnelCard(
                                      personnel: sl<PersonnelListBloc>()
                                          .filteredPersonnel[index]);
                                },
                              )
                        : state is FetchPersonnelListFailedState
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      fontSize:
                                          sl<SizeHelper>().getTextSize(15),
                                      text: state.error,
                                      textColor: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.amber),
                                      onPressed: () {
                                        sl<PersonnelListBloc>()
                                            .add(FetchPersonnelListEvent());
                                      },
                                      child: CustomText(
                                        fontSize:
                                            sl<SizeHelper>().getTextSize(16),
                                        text: "Retry",
                                        textColor: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : SizedBox();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => PersonnelFormScreen())),
        child: Container(
          width: sl<SizeHelper>().getWidgetWidth(50),
          height: sl<SizeHelper>().getWidgetHeight(50),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 250, 195, 75),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.add,
            size: sl<SizeHelper>().getWidgetWidth(30),
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
