const Joi = require('@hapi/joi');

const registerValidation = data => {
    console.log(data);
    data.isAdmin = Boolean(data.isAdmin)
    const schema = Joi.object({
        username: Joi.string()
            .min(6).required(),
        password: Joi.string()
            .min(6)
            .required(),
        isAdmin: Joi.boolean()            
    });
    
    return schema.validate(data);
}

module.exports.registerValidation = registerValidation;
