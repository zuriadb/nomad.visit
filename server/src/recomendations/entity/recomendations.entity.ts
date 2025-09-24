import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";
import { estimatedPriceEnum } from "../enum/estimated-price.enum";

@Entity()
export class RecommendationEntity {

  @PrimaryGeneratedColumn('uuid')
  id : string;

  @Column()
  placeName: string;

  @Column()
  description: string; 

  @Column()
  reason: string;
  
  @Column()
  estimatedPrice: estimatedPriceEnum;

  @Column()
  timeToVisit: string;

}