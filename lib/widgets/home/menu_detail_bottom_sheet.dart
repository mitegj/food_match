import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morning_brief/models/ingredient_model.dart';
import 'package:morning_brief/models/menu_ingredients_model.dart';
import 'package:morning_brief/models/menu_model.dart';
import 'package:morning_brief/utils/UIColors.dart';

class DetailBottomSheet extends StatelessWidget {
  DetailBottomSheet({Key? key, required this.menu, required this.ingredients})
      : super(key: key);
  final MenuModel menu;
  final List<IngredientModel>? ingredients;

  String getIngredientName(String id) {
    return ingredients!.where((el) => el.id == id).single.listName;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Container(
      height: mediaQuery.size.height * 0.85,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: UIColors.white),
      child: Column(children: [
        Expanded(
            child: ListView(
          children: [
            Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(menu.kcal.toString(),
                                style: GoogleFonts.poppins(
                                    color: UIColors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300)),
                            Text('kcal',
                                style: GoogleFonts.poppins(
                                    color: UIColors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300))
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(menu.difficulty.toString(),
                                style: GoogleFonts.poppins(
                                    color: UIColors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300)),
                            Text('livello',
                                style: GoogleFonts.poppins(
                                    color: UIColors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300))
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(menu.preparationTime.toString(),
                                style: GoogleFonts.poppins(
                                    color: UIColors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300)),
                            Text('ore',
                                style: GoogleFonts.poppins(
                                    color: UIColors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300))
                          ],
                        )
                      ],
                    )),
                SizedBox(
                  height: 30,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: UIColors.bluelight,
                    ),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                      fit: BoxFit.cover,
                      height: mediaQuery.size.height * 0.2,
                      width: mediaQuery.size.width * 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(menu.menuName.toString(),
                        style: GoogleFonts.poppins(
                            color: UIColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                  ],
                ),

                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(menu.note.toString(),
                      style: GoogleFonts.poppins(
                          color: UIColors.pink,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Ingredienti",
                      style: GoogleFonts.poppins(
                          color: UIColors.lightBlack,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (var item in menu.ingredients)
                      IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Expanded(
                                child: Text(
                                    item!.qty.toString() +
                                        item.unit +
                                        " " +
                                        getIngredientName(item.id.toString()),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.visible,
                                    style: GoogleFonts.poppins(
                                        color: UIColors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Procedimento",
                      style: GoogleFonts.poppins(
                          color: UIColors.lightBlack,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    for (var item in menu.steps)
                      IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              VerticalDivider(
                                width: 50,
                                thickness: 5,
                                color: UIColors.lightBlack,
                              ),
                              Expanded(
                                child: Text(item,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.visible,
                                    style: GoogleFonts.poppins(
                                        color: UIColors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300)),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                InkWell(
                  onTap: (){},
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: UIColors.lightGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            size: 25,
                            color: UIColors.black,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Piatto cucinato',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        )),
      ]),
    );
  }
}
