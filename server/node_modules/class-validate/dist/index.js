"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.parseClassParams = exports.Parse = exports.validate = exports.getValidator = exports.getValidateDescriptor = exports.IsOptional = exports.IsPhoneNumber = exports.IsHex = exports.IsUrl = exports.IsFloat = exports.IsInteger = exports.IsMethod = exports.IsAny = exports.IsEnum = exports.IsObject = exports.IsRegeExp = exports.IsDate = exports.IsEmail = exports.IsArray = exports.IsBoolean = exports.IsString = exports.IsNumber = exports.Validator = void 0;
require("reflect-metadata");
const async_validator_1 = __importDefault(require("async-validator"));
function Validator(rule) {
    rule = rule || {};
    rule = Object.assign({ required: true }, rule);
    return function (target, propertyKey) {
        const rules = Reflect.getOwnMetadata("validate#" + propertyKey, target.constructor) ||
            [];
        rules.push(rule);
        Reflect.defineMetadata("validate#" + propertyKey, rules, target.constructor);
        return rules;
    };
}
exports.Validator = Validator;
function IsNumber(rule) {
    return function (target, propertyKey) {
        rule = rule || {};
        rule.type = "number";
        Validator(rule)(target, propertyKey);
    };
}
exports.IsNumber = IsNumber;
function IsString(rule) {
    return function (target, propertyKey) {
        rule = rule || {};
        rule.type = "string";
        Validator(rule)(target, propertyKey);
    };
}
exports.IsString = IsString;
function IsBoolean(rule) {
    return function (target, propertyKey) {
        rule = rule || {};
        rule.type = "boolean";
        Validator(rule)(target, propertyKey);
    };
}
exports.IsBoolean = IsBoolean;
function IsArray(rule) {
    return function (target, propertyKey) {
        rule = rule || {};
        rule.type = "array";
        Validator(rule)(target, propertyKey);
    };
}
exports.IsArray = IsArray;
function IsEmail(rule) {
    return function (target, propertyKey) {
        rule = rule || {};
        rule.type = "email";
        Validator(rule)(target, propertyKey);
    };
}
exports.IsEmail = IsEmail;
function IsDate(rule) {
    return function (target, propertyKey) {
        rule = rule || {};
        rule.type = "date";
        Validator(rule)(target, propertyKey);
    };
}
exports.IsDate = IsDate;
function IsRegeExp(rule) {
    return function (target, propertyKey) {
        rule = rule || {};
        rule.type = "regexp";
        Validator(rule)(target, propertyKey);
    };
}
exports.IsRegeExp = IsRegeExp;
function IsObject(rule) {
    return function (target, propertyKey) {
        rule = rule || {};
        rule.type = "regexp";
        Validator(rule)(target, propertyKey);
    };
}
exports.IsObject = IsObject;
function IsEnum(rule) {
    return function (target, propertyKey) {
        rule = rule || {};
        rule.type = "enum";
        Validator(rule)(target, propertyKey);
    };
}
exports.IsEnum = IsEnum;
function IsAny(rule) {
    return function (target, propertyKey) {
        rule = rule || {};
        rule.type = "any";
        Validator(rule)(target, propertyKey);
    };
}
exports.IsAny = IsAny;
function IsMethod(rule) {
    return function (target, propertyKey) {
        rule = rule || {};
        rule.type = "method";
        Validator(rule)(target, propertyKey);
    };
}
exports.IsMethod = IsMethod;
function IsInteger(rule) {
    return function (target, propertyKey) {
        rule = rule || {};
        rule.type = "integer";
        Validator(rule)(target, propertyKey);
    };
}
exports.IsInteger = IsInteger;
function IsFloat(rule) {
    return function (target, propertyKey) {
        rule = rule || {};
        rule.type = "float";
        Validator(rule)(target, propertyKey);
    };
}
exports.IsFloat = IsFloat;
function IsUrl(rule) {
    return function (target, propertyKey) {
        rule = rule || {};
        rule.type = "url";
        Validator(rule)(target, propertyKey);
    };
}
exports.IsUrl = IsUrl;
function IsHex(rule) {
    return function (target, propertyKey) {
        rule = rule || {};
        rule.type = "hex";
        Validator(rule)(target, propertyKey);
    };
}
exports.IsHex = IsHex;
function IsPhoneNumber(rule) {
    return function (target, propertyKey) {
        rule = rule || {};
        rule.pattern = /^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$/;
        rule.message = rule.message || `${propertyKey} must be phone number`;
        Validator(rule)(target, propertyKey);
    };
}
exports.IsPhoneNumber = IsPhoneNumber;
function IsOptional() {
    return function (target, propertyKey) {
        const rules = Validator({ required: false, optional: true })(target, propertyKey);
        rules.forEach((r) => {
            r.required = false;
        });
    };
}
exports.IsOptional = IsOptional;
const getValidateDescriptor = (classDefined) => {
    const descriptor = {};
    Reflect.getMetadataKeys(classDefined).forEach((item) => {
        if (item.startsWith("validate#")) {
            const key = item.replace("validate#", "");
            descriptor[key] = Reflect.getOwnMetadata(item, classDefined);
        }
    });
    return descriptor;
};
exports.getValidateDescriptor = getValidateDescriptor;
const getValidator = (classDefined) => {
    const descriptor = exports.getValidateDescriptor(classDefined);
    return new async_validator_1.default(descriptor);
};
exports.getValidator = getValidator;
function validate(classDefined, params, options) {
    const validator = classDefined instanceof async_validator_1.default ? classDefined : exports.getValidator(classDefined);
    return validator.validate(params, options);
}
exports.validate = validate;
// Parse
function Parse(type) {
    return function (target, propertyKey) {
        Reflect.defineMetadata("parse#" + propertyKey, type, target.constructor);
    };
}
exports.Parse = Parse;
let parsers = new Map();
const parseClassParams = (classDefined, params) => {
    let parser = parsers.get(classDefined);
    if (!parser) {
        let parseSchema = {};
        Reflect.getMetadataKeys(classDefined).forEach((item) => {
            if (item.startsWith("parse#")) {
                const key = item.replace("parse#", "");
                parseSchema[key] = Reflect.getOwnMetadata(item, classDefined);
            }
        });
        parser = (value) => {
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
                    }
                    catch (error) {
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
exports.parseClassParams = parseClassParams;
