import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gerenciamento_pessoal_mobile/controllers/home_controller.dart';
import 'package:gerenciamento_pessoal_mobile/controllers/login_controller.dart';
import 'package:gerenciamento_pessoal_mobile/resources/global_colors.dart';
import 'package:gerenciamento_pessoal_mobile/views/financial/index.dart';
import 'package:gerenciamento_pessoal_mobile/views/login/index.dart';
import 'package:gerenciamento_pessoal_mobile/views/shopping/index.dart';
import 'package:gerenciamento_pessoal_mobile/views/tasks/index.dart';
import 'package:get_it/get_it.dart';

import '../../resources/widgets/globals.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = GetIt.I.get<HomeController>();
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  void initState() {
    homeController.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
      backgroundColor: GlobalColors.silver,
      body: homeController.isLoading ? const Center(child: LoadWidget(),) :
        PageView(
        
        controller: _pageController,
        onPageChanged: (index) => setState(() {
          _currentIndex = index;
        }),
        children: [
          BodyHomeScreen(homeController: homeController),
          const ShoppingScrean(), //market
          const FinancialScreen(), // financial
          const TasksScreen(), // tasks
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
          _pageController.jumpToPage(index);
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
         ),
         BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Compras'
         ),
         BottomNavigationBarItem(
          icon: Icon(Icons.attach_money),
          label: 'Financeiro'
         ),
         BottomNavigationBarItem(
          icon: Icon(Icons.note_alt_rounded),
          label: 'Tarefas'
         ),
        ]
      ),
    );
    });
  }
}

class BodyHomeScreen extends StatelessWidget {
  const BodyHomeScreen({required this.homeController, super.key});

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BoxOne(),
        const SizedBox(height: 35,),
        Expanded(child: 
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              boxShadow: [BoxShadow(color: Colors.white, blurRadius: 6)]
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(onPressed: () {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(
                            builder: (context) => const LoginView()),
                        (Route<dynamic> route) => false,
                      );
                      },
                       child: const Text('Desconectar', style: TextStyle(color: Colors.red),)),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border.symmetric(horizontal: BorderSide(color: GlobalColors.navy, width: 3))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Montante do mês atual:', 
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                        ),
                        Text(homeController.wallet.total != null ? "R\$ ${homeController.wallet.total.toString()}" : "R\$ 0.0", 
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                    ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Total de tarefas para o dia de hoje: ${homeController.tasks.length}', 
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 19),
                            ),
                        ...homeController.tasks.map((element) => Text(element.name ?? '')),

                        ],
                      ),
                    ),
                  )
                  
                ],
              )
            ),
            )
          )
      ],
    );
  }
}

class BoxOne extends StatelessWidget {
  BoxOne({
    Key? key,
  }) : super(key: key);

  final LoginController loginController = GetIt.I.get<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(height: 200, child: HorizontalBackgraoundImage()),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          color: Colors.transparent,
          child: IntrinsicHeight(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 100),
                  child: GestureDetector(
                    onHorizontalDragEnd: (details) {
                      // if (details.primaryVelocity != null) {
                      //   if (details.primaryVelocity! <= 0) {
                      //     Navigator.of(context).push(CustomPageRoute(
                      //       child: const ProfileView(),
                      //       direction: AxisDirection.left,
                      //     ));
                      //   }
                      // }
                    },
                    child: Container(
                      height: 120,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            offset: Offset(0, 5),
                            color: Colors.white10,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        color: GlobalColors.navy,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Icon(
                                  Icons.drag_indicator_rounded,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 8),
                                child: Container(
                                  height: 75,
                                  width: 56,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'assets/images/avatar.png'))),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text( loginController.user?.name != null? loginController.user!.name! : 'User Name',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text( loginController.user?.email != null? loginController.user!.email! : 'User Email',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const LogoWidget(
                  topPadding: 24,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}