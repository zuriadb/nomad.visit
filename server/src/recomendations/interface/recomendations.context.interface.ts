export interface LlmContext {
  cityName: string;
  userPreferences?: string; 
  currentWeather?: string;  
  timeOfDay?: 'утро' | 'день' | 'вечер';
  season?: 'лето' | 'зима' | 'весна' | 'осень';
}