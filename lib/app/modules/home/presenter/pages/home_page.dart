import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/helpers/utils.dart';
import '../../../../core/theme/colors.dart';
import '../../../char_details/presenter/pages/char_details_page.dart';
import '../../domain/entities/char.dart';
import '../controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController _controller;
  @override
  void initState() {
    super.initState();
    _controller = context.read<HomeController>();

    _controller.loadAllCharsCategories();
    _setupErrorListener();
    
  }

  _setupErrorListener() {
    _controller.errorMessageBS.listen((value) { 
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: kPrimaryRed,
          content: Text(
            value,
            style: const TextStyle(
              color: kPrimaryWhite,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          )
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildAppbarTitle(),
        leading: IconButton(
          onPressed: () {}, 
          icon: SvgPicture.asset(
            'assets/icons/menu.svg',
            width: 24,
            height: 24,
            color: Colors.black,
          )
        ),
        centerTitle: true,
        elevation: 2,
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              width: 24,
              height: 24,
              color: Colors.black,
            )
          )
        ],
      ),
      backgroundColor: kPrimaryWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: _buildHeader(),
            ),
            _buildCategoryFilter(),
            StreamBuilder<bool>(
              stream: _controller.isLoading,
              initialData: false,
              builder: (context, snapshot) {
                if(snapshot.data!) {
                  return _buildLoading();
                }

                return StreamBuilder<Map<CharCategory, List<Char>>>(
                  stream: _controller.charsByCategoryBS, 
                  initialData: const {},
                  builder: (context, snapshot) {
                    final _charsByCategory = snapshot.data;
                    return Column(
                      children: _charsByCategory!.entries.map((e) {
                       return  _buildCategoryList(
                          category: e.key, 
                          chars: e.value
                        );
                      }).toList()
                    );
                  }
                );
              }
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAppbarTitle() {
    return SvgPicture.asset(
      'assets/icons/marvel.svg',
      color: kPrimaryRed,
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Bem vindo ao Marvel Heroes',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: kPrimaryGrey, fontSize: 14, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Escolha seu personagem',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: kPrimaryBlack,
            fontSize: 32,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryButton({
    required String assetPath, 
    required LinearGradient gradient,
    required VoidCallback onTap
  }) {
    return GestureDetector(
      child: Container(
        height: 56,
        width: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(  
          shape: BoxShape.circle,
          gradient: gradient
        ),
        child: SvgPicture.asset(
          assetPath,
          height: 32,
          width: 32,
          color: kPrimaryWhite,
        )
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCategoryButton(  
          assetPath: 'assets/icons/hero.svg',
          gradient: kGradientBlue,
          onTap: () {}
        ),
        _buildCategoryButton(  
          assetPath: 'assets/icons/villain.svg',
          gradient: kGradientRed,
          onTap: () {}
        ),
        _buildCategoryButton(  
          assetPath: 'assets/icons/antihero.svg',
          gradient: kGradientPurple,
          onTap: () {}
        ),
        _buildCategoryButton(  
          assetPath: 'assets/icons/alien.svg',
          gradient: kGradientGreen,
          onTap: () {}
        ),
        _buildCategoryButton(  
          assetPath: 'assets/icons/human.svg',
          gradient: kGradientPink,
          onTap: () {}
        ),
      ],
    );
  }

  Widget _buildCategoryList({
    required CharCategory category,
    required List<Char> chars
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                 Text(
                  convertCategoryName(category),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: kPrimaryRed,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                /*TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Ver tudo',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: kPrimaryGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),*/
              ],
            ),
          ),
          const SizedBox(height: 5,),
          SizedBox(
            height: 230,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 24),
              scrollDirection: Axis.horizontal,
              itemCount: chars.length,
              itemBuilder: (_, i) {
                return _buildCharacterTile(
                  char: chars[i]
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCharacterTile({
    required Char char,
  }) {    
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CharDetailsPage(char: char),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(12),
        height: 230,
        width: 140,
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: AssetImage(Utils.convertCharImagePathToAssetPath(char.imagePath),
              ),
            ),
          ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              char.alterEgo,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: kPrimaryWhite,
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              char.name,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: kPrimaryWhite,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Column(
      children: List.generate(5, (index) => _buildShimmeredList())
    );
  }

  Widget _buildShimmeredList() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: kPrimaryRed,
                  highlightColor: kPrimarySilver,
                  child: const Text(
                    'Categorias',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: kPrimaryRed,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          SizedBox(
            height: 230,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 24),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (_, i) {
                return Shimmer.fromColors(
                  baseColor: Colors.black12,
                  highlightColor: Colors.white,
                  direction: ShimmerDirection.ltr,
                  child: Container(
                    margin: const EdgeInsets.only(right: 16),
                    padding: const EdgeInsets.all(12),
                    height: 230,
                    width: 140,
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const SizedBox()
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  String convertCategoryName(CharCategory category) {
    switch (category) {
      case CharCategory.heroes:
        return 'Heróis';
      case CharCategory.aliens:
        return 'Aliens';
      case CharCategory.antiHeroes:
        return 'Anti-Heróis';
      case CharCategory.humans:
        return 'Humanos';
      case CharCategory.villains:
        return 'Vilões';
    }
  }
}
