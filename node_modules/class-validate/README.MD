package using `async-validator` is Validator Schema

Example:

```typescript
import {
  getValidateDescriptor,
  IsNumber,
  IsPhoneNumber,
  IsString,
  validate,
} from "../dist";

class User {
  @IsString()
  name: string;

  @IsNumber()
  age: number;

  @IsPhoneNumber()
  phone: string;
}

const descriptor = getValidateDescriptor(User);
// ===> descriptor
{
  name: [{ required: true, type: "string" }],
  age: [{ required: true, type: "number" }],
  phone: [
    {
      required: true,
      pattern: /^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$/,
      message: "phone must be phone number",
    },
  ],
};
```

Validate params with `User` class

```typescript
import { IsString, Parse, parseClassParams, validate } from "../dist";

const params = {
  name: "Join he",
  age: "10",
  phone: "+84971324827",
};

validate(User, params)
  .then(() => {
    console.log("validate success");
  })
  .catch(({ errors }) => {
    console.log(errors);
    // [ { message: 'age is not a number', field: 'age' } ]
  });
```

Parse params before validate

```typescript
class User {
    ...

    @IsNumber()
    @Parse("number")
    age: number;

    ...
}

validate(User, parseClassParams(User, params)).then(() => {
  console.log("validate success");
});


```

All decorator

`Validator` `IsNumber` `IsString` `IsBoolean` `IsArray` `IsEmail` `IsDate` `IsRegeExp` `IsObject` `IsEnum` `IsAny` `IsMethod` `IsInteger` `IsFloat` `IsUrl` `IsHex` `IsPhoneNumber` `IsOptional` `Parse`

Methods

`validate` `parseClassParams` `getValidateDescriptor` `getValidator`
