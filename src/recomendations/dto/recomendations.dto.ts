import { IsEnum, IsString } from "class-validator";
import { ApiProperty } from "@nestjs/swagger";
import { timeOfDayEnum } from "../enum/time-of-day.enum";
import { seasonsEnum } from "../enum/seasons.enum";

export class LlmContextDto {

  @ApiProperty() 
  @IsString() 
  cityName: string;

  @ApiProperty()
  @IsString()
  userPreferences: string; 

  @ApiProperty()
  @IsString()
  currentWeather: string;  

  @ApiProperty()
  @IsEnum(timeOfDayEnum)
  timeOfDay: timeOfDayEnum;

  @ApiProperty()
  @IsEnum(seasonsEnum)
  season: seasonsEnum;
}
