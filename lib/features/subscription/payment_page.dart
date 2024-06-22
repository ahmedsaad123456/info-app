import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:info_app/features/subscription/subscripe_page.dart';
import 'package:info_app/widget/custom_button.dart';

import '../../widget/subscripe_widget.dart';
import 'model.dart';

class PaymentPage extends StatefulWidget {
  final SubscriptionData data;
  const PaymentPage({super.key, required this.data});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  List<String> bank = ['assets/icons/stripe.svg',
                        'assets/icons/t-bank.svg',
                         'assets/icons/paypal.svg',
                          'assets/icons/visa.svg'
                                               ];

  List<Color> bankColor = [Colors.white,Colors.yellow,  Colors.white,  Colors.white.withOpacity(0.12)];


  void _showDraggableScrollableSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.8,
          builder: (context, scrollController) {
            return Container(
              color: const Color.fromRGBO(31, 31, 31, 1),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                controller: scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        Container(
                          height: 4,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(height: 65),
                        SvgPicture.asset('assets/icons/Checkbox.svg'),
                        const SizedBox(height: 16),
                        const Text("Подписка успешно\n оформлена!", style: TextStyle(
                          fontSize: 28, fontWeight: FontWeight.w500, color: Colors.white
                        ), textAlign: TextAlign.center,),
                        const SizedBox(height: 65),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ButtonWidget(text: 'Закрыть', height: 52, color: const Color.fromRGBO(248, 32, 110, 1),
                              textColor: Colors.white, onTap: (){
                            Navigator.pop(context);
                            },),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: const Icon(Icons.arrow_back_ios, color: Colors.white,)),
                      const SizedBox(
                        width: 40,
                      ),
                      const Text('Оформление подписки', style: TextStyle(
                          fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400
                      ),)
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                   SizedBox(
                     width: MediaQuery.of(context).size.width,
                     child: SubscripeWidget(color: Colors.white, text: widget.data.text, cost: widget.data.cost, description: widget.data.description,
                      selected: true, textColor: widget.data.text == 'Нейро+'  ? Colors.red : Colors.white.withOpacity(0.48),
                                   ),
                   ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text('Способ оплаты', style: TextStyle(fontSize: 28, color: Colors.white),),
                  const SizedBox(
                    height: 24,
                  ),
                   GridView.builder(
                     shrinkWrap: true,
                     itemCount: bank.length,
                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 2,
                       childAspectRatio: 2,
                       crossAxisSpacing: 12,
                       mainAxisSpacing: 12
                   ), itemBuilder: (BuildContext context, int index) {
                       return GestureDetector(
                         onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => const SubscribeScreen())).then((value) => _showDraggableScrollableSheet());
                           _showDraggableScrollableSheet();
                         },
                         child: Container(
                             width: 147,
                             height: 147,
                          decoration: BoxDecoration(
                            color: bankColor[index],
                            borderRadius: BorderRadius.circular(8)
                          ),
                           child: SvgPicture.asset(bank[index], fit: BoxFit.scaleDown,),
                         ),
                       );
                   },)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
