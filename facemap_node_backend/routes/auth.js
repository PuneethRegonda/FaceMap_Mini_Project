const router = require('express').Router();
const User = require('../models/user')
const Token = require('../models/token')
const { registerValidation } = require('../validation')
const bcrypt = require('bcryptjs');
const crypto = require('crypto');
const Location = require("../models/location")
const jwt = require('jsonwebtoken');

router.post('/register', async(req, res) => {
    // validatoin
    const { error } = registerValidation(req.body);
    if (error)
        return res.status(400).send({ status: 'failed', message: error.details[0].message });
    // alreafy exists
    const usernameExist = await User.findOne({ username: req.body.username });
    if (usernameExist) return res.status(400).send({ status: 'failed', message: 'Username already Exists' })
    console.log('bcrypt magic code ');
    // bcrypt magic code 
    const salt = await bcrypt.genSalt(10);
    const hassword = await bcrypt.hash(req.body.password, salt);

    // setting admin/normal user
    let isAdmin = false;
    if (req.body.isAdmin) isAdmin = req.body.isAdmin;

    const newUser = User({
        username: req.body.username,
        password: hassword,
        isAdmin: isAdmin
    });

    try {

        const savedUser = await newUser.save();
        console.log("generate token");
        // generate token
        // const  auth_token = jwt.sign({_id:user._id,createdAt: Date.now()},process.env.SECRET_TOKEN) 

        // gen verification token and saving that token in db, which will expire in an hour    
        const token = new Token({ _userId: savedUser._id, token: crypto.randomBytes(64).toString('hex') });

        await token.save();

        console.log(token);
        console.log("user registered ");

        res.send({ status: 'success', message: 'Registeration Successful' });
    } catch (err) {
        res.status(400).send(err);
    }
});



router.post('/login', async(req, res) => {
    const { error } = registerValidation(req.body);
    if (error)
        return res.status(400).send({ status: 'failed', message: error.details[0].message });

    // alreafy exists
    const user = await User.findOne({ username: req.body.username });
    if (!user) return res.status(400).send({ status: 'failed', message: 'username or password not valid' })

    //  valid password 
    const validPass = await bcrypt.compare(req.body.password, user.password);

    // password does not matched
    if (!validPass) return res.status(400).send({ status: 'failed', message: 'username or password not valid' })
    console.log(Date.now())

    const auth_token = jwt.sign({ _id: user._id }, process.env.SECRET_TOKEN)

    return res.header('auth-token', auth_token).send({ status: 'success', message: 'Logged In' });
});

router.post('/dashboard', async(req, res) => {
    const { error } = registerValidation(req.body);
    if (error)
        return res.status(400).send({ status: 'failed', message: error.details[0].message });

    // alreafy exists
    const user = await User.findOne({ username: req.body.username });
    if (!user) return res.status(400).send({ status: 'failed', message: 'username or password not valid' })

    //  valid password 
    const validPass = await bcrypt.compare(req.body.password, user.password);

    // password does not matched
    if (!validPass) return res.status(400).send({ status: 'failed', message: 'username or password not valid' })
    console.log(Date.now())

    const auth_token = jwt.sign({ _id: user._id }, process.env.SECRET_TOKEN)
    const location = await Location.find();
    return res.header('auth-token', auth_token).send({ status: 'success', message: 'Logged In', data: { "location": location } });
});


module.exports = router;