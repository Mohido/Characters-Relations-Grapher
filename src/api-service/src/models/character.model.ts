export interface CharacterModel {
    name: string;
    attributes: Array<string>; // This field can be extended to a new model
    createdAt: Date;
    updatedAt: Date;
}