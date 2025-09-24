import { estimatedPriceEnum } from "../enum/estimated-price.enum";

export interface Recommendation {
  placeName: string;
  description: string; 
  reason: string; 
  estimatedPrice: estimatedPriceEnum;
  timeToVisit: string;
}