import {
  getValidateDescriptor,
  IsNumber,
  IsPhoneNumber,
  IsString,
  Parse,
  parseClassParams,
  validate,
} from "../dist";

class User {
  @IsString()
  name: string;

  @IsNumber()
  @Parse("number")
  age: number;

  @IsPhoneNumber()
  phone: string;
}

const descriptor = getValidateDescriptor(User);

console.log(descriptor);

const params = {
  name: "Join he",
  age: "10",
  phone: "+84971324827",
};

validate(User, params)
  .then(() => {
    console.log("validate success");
  })
  .catch(({ errors, fields }: any) => {
    console.log(errors);
  });

validate(User, parseClassParams(User, params)).then(() => {
  console.log("validate success");
});
