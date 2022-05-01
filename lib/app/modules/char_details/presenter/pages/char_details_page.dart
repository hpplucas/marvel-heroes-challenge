import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/helpers/utils.dart';
import '../../../../core/theme/colors.dart';
import '../../../home/domain/entities/ability.dart';
import '../../../home/domain/entities/char.dart';
import '../../../home/domain/entities/meansure.dart';
import '../../../home/domain/entities/movie.dart';



class CharDetailsPage extends StatefulWidget {
  final Char char;


  const CharDetailsPage({
    Key? key,
    required this.char,
  }) : super(key: key);

  @override
  State<CharDetailsPage> createState() => _CharDetailsPageState();
}

class _CharDetailsPageState extends State<CharDetailsPage> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200)
    );

    animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController);

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
        elevation: 0,
        backgroundColor: kPrimaryBlack.withOpacity(0.6)
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: kPrimaryBlack,
      body: FadeTransition(
        opacity: animationController,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          //padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Utils.convertCharImagePathToAssetPath(widget.char.imagePath))
            )
          ),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  kPrimaryBlack.withOpacity(0.05),
                  kPrimaryBlack.withOpacity(0.75)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              ),
            ),
            child: SingleChildScrollView(  
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.char.alterEgo,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: kPrimaryWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          widget.char.name,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: kPrimaryWhite,
                            fontSize: 36,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: _buildCaracteristicsBar(),
                        ),
                        Text(
                          widget.char.biography,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: kPrimaryWhite,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: _buildAbilitySection(widget.char.abilities),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: _buildMoviesSection(widget.char.movies),
                  )
                ],
              )
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCaracteristicsBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _caracteristicItem(
          iconPath: 'assets/icons/age.svg', 
          value: widget.char.caracteristics.birth
        ),
        _caracteristicItem(
          iconPath: 'assets/icons/weight.svg', 
          value: _formatMeansureString(widget.char.caracteristics.weight)
        ),
        _caracteristicItem(
          iconPath: 'assets/icons/height.svg', 
          value: _formatMeansureString(widget.char.caracteristics.height)
        ),
        _caracteristicItem(
          iconPath: 'assets/icons/universe.svg', 
          value: widget.char.caracteristics.universe
        ),
      ],
    );
  }

  String _formatMeansureString(Mensure mensure) {
    double value = mensure.value;
    String unity = mensure.unity;
    return '${value.toStringAsFixed(2)} $unity';
  }

  Widget _caracteristicItem({required String iconPath, required String value}) {
    return Column(
      children: [
        SvgPicture.asset(
          iconPath,
          color: kPrimaryWhite,
        ),
        const SizedBox(height: 12,),
        Text(
          value,
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: kPrimaryWhite,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildAbilitySection(Ability abilities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Habilidades',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: kPrimaryWhite,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 24,),
        _buildAbilityRow(
          title: 'Força:', 
          value: abilities.force
        ),
        _buildAbilityRow(
          title: 'Inteligência:', 
          value: abilities.intelligence
        ),
        _buildAbilityRow(
          title: 'Agilidade:', 
          value: abilities.force
        ),
        _buildAbilityRow(
          title: 'Resistência:', 
          value: abilities.endurance
        ),
        _buildAbilityRow(
          title: 'Velocidade:', 
          value: abilities.velocity
        ),
      ],
    );
  }

  Widget _buildAbilityRow({required String title, required int value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Text(
              title,
              style: const TextStyle(
                color: kPrimaryWhite,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: LinearProgressIndicator(
              backgroundColor: kPrimaryWhite.withOpacity(0.25),
              color: kPrimaryWhite,
              value: value / 100,
              minHeight: 8,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMoviesSection(List<Movie> movies) {
    return Padding(
      padding: const  EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filmes',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: kPrimaryWhite,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            height: 230,
            //width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (_, i) {
                return _buildMoviePoster(Utils.convertCharImagePathToAssetPath(movies[i].banner));
                //return _buildMoviePoster(movies[i].banner);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMoviePoster(String path) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(12),
      height: 230,
      width: 140,
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            image: AssetImage(path),
          ),
        ),
    );
  }
}
