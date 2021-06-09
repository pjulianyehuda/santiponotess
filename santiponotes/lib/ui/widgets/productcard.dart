part of 'widgets.dart';

class ProductCard extends StatefulWidget {

  final Products products;
  ProductCard({this.products});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    Products product = widget.products;
    
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
      ),
      margin: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            radius: 28.0,
            backgroundImage: NetworkImage(product.productImg),

          ),
          title: Text(
            product.productName,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            softWrap: true,
          ),

          subtitle: Text(
            ActivityServices.toIDR(product.productPrice),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
            maxLines: 1,
            softWrap: true,
          ),
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
            //   IconButton(
            //   icon: Icon(CupertinoIcons.pencil_circle_fill),
            //   onPressed: (){

            //   },
            // ),
            IconButton(
              icon: Icon(
                CupertinoIcons.ellipsis_circle_fill,
                color: Colors.blue,
              ),
              onPressed: (){
                showModalBottomSheet(
                  // transitionAnimationController: AnimationController(),
                  context: context, 
                  builder: (BuildContext ctx){
                    return Container(
                      width: double.infinity,
                      height: 80,
                      padding: EdgeInsets.all(0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            icon: Icon(CupertinoIcons.eye_fill),
                            label: Text("Show Data"),
                            onPressed: (){

                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey[500],
                            ),
                          ),

                          ElevatedButton.icon(
                            icon: Icon(CupertinoIcons.pencil),
                            label: Text("Edit Data"),
                            onPressed: (){

                            },
                            
                          ),

                          ElevatedButton.icon(
                            icon: Icon(CupertinoIcons.trash),
                            label: Text("Delete Data"),
                            onPressed: () async{
                              bool result = await ProductServices.deleteProduct(product.productId);
                              if(result){
                                ActivityServices.showToast("Delete data success!", Colors.green);
                              }else{
                                 ActivityServices.showToast("Delete data failed!", Colors.red);
                              }

                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            ],
          )
        ),
      ),
    );
  }
}