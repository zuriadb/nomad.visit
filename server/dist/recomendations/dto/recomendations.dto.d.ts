import { timeOfDayEnum } from "../enum/time-of-day.enum";
import { seasonsEnum } from "../enum/seasons.enum";
export declare class LlmContextDto {
    cityName: string;
    userPreferences: string;
    currentWeather: string;
    timeOfDay: timeOfDayEnum;
    season: seasonsEnum;
}
