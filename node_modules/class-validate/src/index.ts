import "reflect-metadata";
import Schema, { RuleItem, Rules, ValidateOption } from "async-validator";

export function Validator(rule?: RuleItem) {
  rule = rule || {};
  rule = { required: true, ...rule };
  return function (target: any, propertyKey: string) {
    const rules =
      Reflect.getOwnMetadata("validate#" + propertyKey, target.constructor) ||
      [];
    rules.push(rule);
    Reflect.defineMetadata(
      "validate#" + propertyKey,
      rules,
      target.constructor
    );
    return rules;
  };
}

export function IsNumber(rule?: RuleItem) {
  return function (target: any, propertyKey: string) {
    rule = rule || {};
    rule.type = "number";
    Validator(rule)(target, propertyKey);
  };
}

export function IsString(rule?: RuleItem) {
  return function (target: any, propertyKey: string) {
    rule = rule || {};
    rule.type = "string";
    Validator(rule)(target, propertyKey);
  };
}

export function IsBoolean(rule?: RuleItem) {
  return function (target: any, propertyKey: string) {
    rule = rule || {};
    rule.type = "boolean";
    Validator(rule)(target, propertyKey);
  };
}

export function IsArray(rule?: RuleItem) {
  return function (target: any, propertyKey: string) {
    rule = rule || {};
    rule.type = "array";
    Validator(rule)(target, propertyKey);
  };
}

export function IsEmail(rule?: RuleItem) {
  return function (target: any, propertyKey: string) {
    rule = rule || {};
    rule.type = "email";
    Validator(rule)(target, propertyKey);
  };
}

export function IsDate(rule?: RuleItem) {
  return function (target: any, propertyKey: string) {
    rule = rule || {};
    rule.type = "date";
    Validator(rule)(target, propertyKey);
  };
}

export function IsRegeExp(rule?: RuleItem) {
  return function (target: any, propertyKey: string) {
    rule = rule || {};
    rule.type = "regexp";
    Validator(rule)(target, propertyKey);
  };
}

export function IsObject(rule?: RuleItem) {
  return function (target: any, propertyKey: string) {
    rule = rule || {};
    rule.type = "regexp";
    Validator(rule)(target, propertyKey);
  };
}

export function IsEnum(rule?: RuleItem) {
  return function (target: any, propertyKey: string) {
    rule = rule || {};
    rule.type = "enum";
    Validator(rule)(target, propertyKey);
  };
}

export function IsAny(rule?: RuleItem) {
  return function (target: any, propertyKey: string) {
    rule = rule || {};
    rule.type = "any";
    Validator(rule)(target, propertyKey);
  };
}

export function IsMethod(rule?: RuleItem) {
  return function (target: any, propertyKey: string) {
    rule = rule || {};
    rule.type = "method";
    Validator(rule)(target, propertyKey);
  };
}

export function IsInteger(rule?: RuleItem) {
  return function (target: any, propertyKey: string) {
    rule = rule || {};
    rule.type = "integer";
    Validator(rule)(target, propertyKey);
  };
}

export function IsFloat(rule?: RuleItem) {
  return function (target: any, propertyKey: string) {
    rule = rule || {};
    rule.type = "float";
    Validator(rule)(target, propertyKey);
  };
}

export function IsUrl(rule?: RuleItem) {
  return function (target: any, propertyKey: string) {
    rule = rule || {};
    rule.type = "url";
    Validator(rule)(target, propertyKey);
  };
}

export function IsHex(rule?: RuleItem) {
  return function (target: any, propertyKey: string) {
    rule = rule || {};
    rule.type = "hex";
    Validator(rule)(target, propertyKey);
  };
}

export function IsPhoneNumber(rule?: RuleItem) {
  return function (target: any, propertyKey: string) {
    rule = rule || {};
    rule.pattern = /^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$/;
    rule.message = rule.message || `${propertyKey} must be phone number`;
    Validator(rule)(target, propertyKey);
  };
}

export function IsOptional() {
  return function (target: any, propertyKey: string) {
    const rules = Validator({ required: false, optional: true } as any)(
      target,
      propertyKey
    );
    rules.forEach((r: any) => {
      r.required = false;
    });
  };
}

export const getValidateDescriptor = (classDefined: any) => {
  const descriptor: Rules = {};
  Reflect.getMetadataKeys(classDefined).forEach((item: string) => {
    if (item.startsWith("validate#")) {
      const key = item.replace("validate#", "");
      descriptor[key] = Reflect.getOwnMetadata(item, classDefined);
    }
  });
  return descriptor;
};

export const getValidator = (classDefined: any): Schema => {
  const descriptor = getValidateDescriptor(classDefined);
  return new Schema(descriptor);
};

export function validate(
  classDefined: any,
  params: any,
  options?: ValidateOption
) {
  const validator =
    classDefined instanceof Schema ? classDefined : getValidator(classDefined);

  return validator.validate(params, options);
}

// Parse
export function Parse(type: "string" | "boolean" | "number" | "date") {
  return function (target: any, propertyKey: string) {
    Reflect.defineMetadata("parse#" + propertyKey, type, target.constructor);
  };
}

let parsers: Map<any, any> = new Map();
export const parseClassParams = (classDefined: any, params: any) => {
  let parser = parsers.get(classDefined);
  if (!parser) {
    let parseSchema: any = {};
    Reflect.getMetadataKeys(classDefined).forEach((item: string) => {
      if (item.startsWith("parse#")) {
        const key = item.replace("parse#", "");
        parseSchema[key] = Reflect.getOwnMetadata(item, classDefined);
      }
    });

    parser = (value: any) => {
      Object.keys(parseSchema).forEach((key) => {
        const type = parseSchema[key];
        if (key in value && value[key] !== undefined && value[key] !== null) {
          try {
            switch (parseSchema[key]) {
              case "string":
                value[key] = String(value[key]);
                break;
              case "number":
                value[key] = Number(value[key]);
                break;
              case "boolean":
                value[key] = Boolean(value[key]);
                break;
              case "date":
                value[key] = new Date(value[key]);
                break;
              default:
                break;
            }
          } catch (error) {
            console.warn(`cannot parse ${value} to ${type} in field ${key}`);
          }
        }
      });
      return value;
    };
    parsers.set(classDefined, parser);
  }
  return parser(params);
};
