import { estimatedPriceEnum } from "../enum/estimated-price.enum";
export declare class RecommendationEntity {
    id: string;
    placeName: string;
    description: string;
    reason: string;
    estimatedPrice: estimatedPriceEnum;
    timeToVisit: string;
}
