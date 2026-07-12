import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("CraftyBay"),

        actions: [

          IconButton(
            onPressed: () {

            },
            icon: const Icon(Icons.search),
          ),

          IconButton(
            onPressed: () {

            },
            icon: const Icon(Icons.person),
          ),

          Stack(
            alignment: Alignment.center,

            children: [

              IconButton(
                onPressed: () {

                },
                icon: const Icon(Icons.shopping_cart),
              ),

              Positioned(
                right: 8,
                top: 8,

                child: Container(
                  width: 18,
                  height: 18,

                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),

                  child: const Center(
                    child: Text(
                      "0",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              )

            ],
          )

        ],
      ),

      body: SingleChildScrollView(

        child: Column(

          children: [

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              child: TextField(

                readOnly: true,

                decoration: InputDecoration(

                  hintText: "Search Product",

                  prefixIcon: const Icon(Icons.search),

                  filled: true,

                  fillColor: Colors.grey.shade200,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),

                ),
              ),
            ),

            const SizedBox(height: 20),

            Container(

              margin: const EdgeInsets.symmetric(horizontal: 16),

              height: 180,

              decoration: BoxDecoration(

                color: Colors.green,

                borderRadius: BorderRadius.circular(15),

              ),

              child: const Center(

                child: Text(

                  "Product Slider",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),

                ),

              ),

            ),

            const SizedBox(height: 25),

            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 16),

              child: Row(

                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: const [

                  Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "See All",
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),

                ],

              ),

            ),

            const SizedBox(height: 12),

            SizedBox(

              height: 90,

              child: ListView.builder(

                scrollDirection: Axis.horizontal,

                itemCount: 8,

                itemBuilder: (context,index){

                  return Container(

                    width: 70,

                    margin: const EdgeInsets.only(left: 15),

                    child: Column(

                      children: [

                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.green.shade100,
                          child: const Icon(Icons.category),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "Category",
                          overflow: TextOverflow.ellipsis,
                        )

                      ],

                    ),

                  );

                },

              ),

            ),

            const SizedBox(height: 25),

            _sectionTitle("Popular"),

            _productList(),

            const SizedBox(height: 25),

            _sectionTitle("Special"),

            _productList(),

            const SizedBox(height: 25),

            _sectionTitle("New"),

            _productList(),

            const SizedBox(height: 30),

          ],

        ),

      ),

    );

  }

  Widget _sectionTitle(String title){

    return Padding(

      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: Row(

        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [

          Text(

            title,

            style: const TextStyle(

              fontSize: 18,

              fontWeight: FontWeight.bold,

            ),

          ),

          const Text(

            "See All",

            style: TextStyle(

              color: Colors.green,

            ),

          )

        ],

      ),

    );

  }

  Widget _productList(){

    return SizedBox(

      height: 250,

      child: ListView.builder(

        scrollDirection: Axis.horizontal,

        itemCount: 10,

        itemBuilder: (context,index){

          return Container(

            width: 170,

            margin: const EdgeInsets.all(10),

            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(12),

              border: Border.all(color: Colors.grey.shade300),

            ),

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Expanded(

                  child: Container(

                    decoration: BoxDecoration(

                      color: Colors.grey.shade200,

                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),

                    ),

                    child: const Center(
                      child: Icon(
                        Icons.image,
                        size: 60,
                      ),
                    ),

                  ),

                ),

                Padding(

                  padding: const EdgeInsets.all(8),

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: const [

                      Text(
                        "Product Name",
                        maxLines: 2,
                      ),

                      SizedBox(height: 6),

                      Text(
                        "\$120",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      )

                    ],

                  ),

                )

              ],

            ),

          );

        },

      ),

    );

  }

}
