import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kasrzero_flutter/Widget/detailsWidget/custom_app_bar.dart';
import 'package:kasrzero_flutter/models/user_data.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/product.dart';
import '../providers/user_provider.dart';
import '../services/user_service.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.getUser();
    var userId = Provider.of<UserProvider>(context, listen: false).user.id;

    Future<List<Product>> getData() async {
      Uri url = Uri.http(KLocalhost, "/user/cartitems/$userId");

      print(url);
      try {
        var response = await http.get(url);
        print(response.body);
        var responseBody = List<Product>.from(
            json.decode(response.body).map((x) => Product.fromJson(x)));
        return responseBody;
      } catch (e) {
        print(e);
        return [];
      }
    }

    Future<void> removeItemFromCart(String productId) async {
      Uri url = Uri.http(KLocalhost, "/user/removefromcart/$userId/$productId");

      await http.post(url);
      // add item to the list
      setState(() {});
    }

    void removecart(String id, String idpro, UserProvider userprovider,
        UserService userserv) {
      print(id);
      var data;
      UserAddress addres = UserAddress();
      userserv.removecart(id, idpro).then((value) => {
            // print(value.body),
            data = json.decode(value.body),
            addres.blockNumber = data["address"]["blockNumber"],
            addres.area = data["address"]["area"],
            addres.city = data["address"]["city"],
            addres.st = data["address"]["st"],
            userprovider.setUser(UserData(
                id: data["_id"],
                userName: data["userName"],
                email: data["email"],
                password: data["password"],
                ads: data["ads"],
                cart: data["cart"],
                orders: data["orders"],
                time: data["time"],
                wishlist: data["wishlist"],
                address: addres,
                phoneNumber: data["phoneNumber"]))
          });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(
          Title: "My Wishlist",
          lead: false,
        ),
      ),
      body: currentUser.id != "id"
          ? Container(
              child: FutureBuilder(
              initialData: [],
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: const CircularProgressIndicator.adaptive());
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  if (snapshot.data!.isEmpty) {
                    return Center(child: Text('Your Cart is empty!!'));
                  }
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        var item = snapshot.data![index];
                        return Container(
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Row(
                            children: [
                              Image.network(
                                item.img[0],
                                height: 120,
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 5),
                                margin: EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: TextStyle(fontSize: 26),
                                    ),
                                    SizedBox(height: 3),
                                    Text("Used For: ${item.durationOfUse}"),
                                    SizedBox(height: 10),
                                    Text(
                                      item.price.toString(),
                                      style: TextStyle(
                                          fontSize: 20, color: KPrimaryColor),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.red),
                                            onPressed: () {
                                              removeItemFromCart(item.id);
                                            },
                                            child: Text("Remove")),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.green,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 42)),
                                            onPressed: () {},
                                            child: Text("Buy"))
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      });
                }
              },
            ))
          : Center(
              child: ElevatedButton(
              child: Text("Login"),
              onPressed: () {
                Navigator.pushNamed(context, '/signin');
              },
            )),
    );
  }
}
