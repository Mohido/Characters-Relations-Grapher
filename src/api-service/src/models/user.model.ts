export interface UserModel {
    username: string;
    createdAt: Date;
    updatedAt: Date;
}

// When the database is up, the application will be able to create Schemas into the database.
// Then models upon the schema creation.

//const UserSchema = new Schema("CREATE TABLE ...");

// UserSchema.methods.confirmPassword = async function (candidatePassword:type) {
//     // Checks whether the password stored in the database 
//     // is the same as the provided password (mostly used on login).
//     const user = this as UserModel;
//     return decryption_function(candidatePassword, user.password).catch((e) => false);
// }

// const User = db.model("User", UserSchema);
// export User;
