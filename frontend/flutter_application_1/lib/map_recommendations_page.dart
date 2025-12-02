import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'services/auth_service.dart'; 


// Модели данных
class RecommendationPlace {
  final String placeName;
  final String description;
  final String reason;
  final String estimatedPrice;
  final String timeToVisit;
  final double lat;
  final double lng;

  RecommendationPlace({
    required this.placeName,
    required this.description,
    required this.reason,
    required this.estimatedPrice,
    required this.timeToVisit,
    required this.lat,
    required this.lng,
  });

  factory RecommendationPlace.fromJson(Map<String, dynamic> json) {
    return RecommendationPlace(
      placeName: json['placeName'] ?? '',
      description: json['description'] ?? '',
      reason: json['reason'] ?? '',
      estimatedPrice: json['estimatedPrice'] ?? '',
      timeToVisit: json['timeToVisit'] ?? '',
      lat: (json['lat'] ?? 43.238949).toDouble(),
      lng: (json['lng'] ?? 76.945465).toDouble(),
    );
  }
}

// Главная страница с картой и рекомендациями
class MapRecommendationsPage extends StatefulWidget {
  final String? accessToken;
  
  const MapRecommendationsPage({
    super.key,
    this.accessToken,
  });

  @override
  State<MapRecommendationsPage> createState() => _MapRecommendationsPageState();
}

class _MapRecommendationsPageState extends State<MapRecommendationsPage> {
  final MapController _mapController = MapController();
  
  List<RecommendationPlace> recommendations = [];
  List<Marker> markers = [];
  bool isLoading = false;
  bool showFilters = true;

  // Параметры генерации
  String cityName = 'Almaty';
  String userPreferences = 'food';
  String currentWeather = 'warm';
  String timeOfDay = 'утро';
  String season = 'весна';

  @override
  void dispose() {
    super.dispose();
  }

  // Генерация рекомендаций через API
  Future<void> generateRecommendations() async {
    setState(() {
      isLoading = true;
      showFilters = false;
    });

    const apiUrl = 'http://localhost:3006/api/v1/recomendations/generate';
    
    try {
      final authService = AuthService();
      final token = await authService.getToken();

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'cityName': cityName,
          'userPreferences': userPreferences,
          'currentWeather': currentWeather,
          'timeOfDay': timeOfDay,
          'season': season,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final List<dynamic> recsData = data['recommendations'] ?? [];
        
        setState(() {
          recommendations = recsData
              .map((json) => RecommendationPlace.fromJson(json))
              .toList();
          _buildMarkers();
        });
      } else {
        _showError('Ошибка ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      _showError('Ошибка подключения: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _buildMarkers() {
    markers = recommendations.map((place) {
      return Marker(
        point: LatLng(place.lat, place.lng),
        width: 40,
        height: 40,
        child: GestureDetector(
          onTap: () => _showPlaceDetails(place),
          child: const Icon(
            Icons.location_on,
            color: Colors.red,
            size: 40,
          ),
        ),
      );
    }).toList();
  }

  void _showPlaceDetails(RecommendationPlace place) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  place.placeName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  place.description,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.lightbulb, color: Colors.orange),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          place.reason,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(
                      label: Text('💰 ${place.estimatedPrice}'),
                      backgroundColor: Colors.green.shade50,
                    ),
                    Chip(
                      label: Text('🕐 ${place.timeToVisit}'),
                      backgroundColor: Colors.purple.shade50,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _mapController.move(
                        LatLng(place.lat, place.lng),
                        16,
                      );
                    },
                    icon: const Icon(Icons.map),
                    label: const Text('Показать на карте'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF18583B),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Карта на весь экран
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(43.238949, 76.945465),
              initialZoom: 12,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.nomadvisit.app',
                maxNativeZoom: 19,
                maxZoom: 19,
              ),
              MarkerLayer(markers: markers),
            ],
          ),

          // Верхняя панель фильтров
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: showFilters ? null : 0,
                child: showFilters
                    ? Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Фильтры',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    setState(() {
                                      showFilters = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildCompactDropdown(
                              'Город',
                              cityName,
                              ['Almaty', 'Astana', 'Shymkent'],
                              (v) => setState(() => cityName = v!),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildCompactDropdown(
                                    'Предпочтение',
                                    userPreferences,
                                    ['food', 'nature', 'culture', 'adventure'],
                                    (v) => setState(() => userPreferences = v!),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _buildCompactDropdown(
                                    'Погода',
                                    currentWeather,
                                    ['warm', 'cold', 'rainy'],
                                    (v) => setState(() => currentWeather = v!),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildCompactDropdown(
                                    'Время',
                                    timeOfDay,
                                    ['утро', 'день', 'вечер', 'ночь'],
                                    (v) => setState(() => timeOfDay = v!),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _buildCompactDropdown(
                                    'Сезон',
                                    season,
                                    ['весна', 'лето', 'осень', 'зима'],
                                    (v) => setState(() => season = v!),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: isLoading ? null : generateRecommendations,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF18583B),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: isLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text('Генерировать'),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),

          // Кнопка показа фильтров (когда скрыты)
          if (!showFilters)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      setState(() {
                        showFilters = true;
                      });
                    },
                    backgroundColor: const Color(0xFF18583B),
                    icon: const Icon(Icons.tune),
                    label: const Text('Фильтры'),
                  ),
                ),
              ),
            ),

          // Нижняя панель с рекомендациями
          if (recommendations.isNotEmpty)
            DraggableScrollableSheet(
              initialChildSize: 0.3,
              minChildSize: 0.1,
              maxChildSize: 0.7,
              builder: (context, scrollController) => Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Text(
                            'Рекомендации',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Chip(
                            label: Text('${recommendations.length}'),
                            backgroundColor: const Color(0xFF78E9A9),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.all(16),
                        itemCount: recommendations.length,
                        itemBuilder: (context, index) {
                          final place = recommendations[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: InkWell(
                              onTap: () {
                                _mapController.move(
                                  LatLng(place.lat, place.lng),
                                  15,
                                );
                                _showPlaceDetails(place);
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF18583B),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            place.placeName,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            place.description,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.black54,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.green.shade50,
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  '💰 ${place.estimatedPrice}',
                                                  style: const TextStyle(fontSize: 11),
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.purple.shade50,
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  '🕐 ${place.timeToVisit}',
                                                  style: const TextStyle(fontSize: 11),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCompactDropdown(
    String label,
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              isDense: true,
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 13),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}